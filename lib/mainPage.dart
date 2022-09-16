// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:manage/detailsPage.dart';
import 'package:manage/helpers.dart';
import 'package:manage/projectData.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dialogs.dart';

class MainPage extends StatefulWidget {
  final List<ProjectData> projectsData;

  const MainPage(this.projectsData, {Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var menuValue = 'איפוס';
  List<ProjectData> projectsData = [];

  @override
  void initState() {
    projectsData = widget.projectsData;
    super.initState();
  }

  Widget get myDivider =>
      Divider(thickness: 1, color: Colors.black12, indent: 15, endIndent: 15);

  @override
  Widget build(BuildContext context) {
    print('Build main page');
    // print('projectsData ${projectsData[0].toJson()}');

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: PopupMenuButton(
                icon: Icon(Icons.more_vert),
                onSelected: (value) async {
                  if (value == 'איפוס') {
                    var isSure = await ruSureDialog(context, "הכל");
                    if (isSure != null && isSure) clearLocally();
                  } else if (value == 'ייצוא') {
                    Share.share(jsonEncode(projectsData));
                  } else if (value == 'ייבוא') {
                    var backupValue =
                        await newProjDialog(context, isNewProj: false);
                    if (backupValue != null && backupValue.isNotEmpty) {
                      projectsData = await getLocally(backupData: backupValue);
                    }
                  }
                  setState(() {});
                },
                itemBuilder: (_) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    value: 'ייצוא',
                    child: Text('ייצוא'),
                  ),
                  PopupMenuItem<String>(
                    value: 'ייבוא',
                    child: Text('ייבוא'),
                  ),
                  PopupMenuItem<String>(
                    value: 'איפוס',
                    child: const Text('איפוס'),
                  ),
                ],
              ),
            )
          ],
          title: Align(
              alignment: Alignment.centerRight,
              child: const Text(
                'ניהול פרוייקטים',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          leadingWidth: 110,
          leading: TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white12)),
            onPressed: () async {
              var formatTime = intl.DateFormat("(dd/MM) HH:mm");
              var nowTime = formatTime.format(DateTime.now());

              var projName = await newProjDialog(context);
              if (projName != null && projName.isNotEmpty) {
                projectsData.add(
                  ProjectData(
                    projectName: projName.toString(),
                    allUpdates: ['הפרוייקט נוצר!'],
                    timeCreated: [nowTime],
                  ),
                );
                saveLocally(projectsData);
                setState(() {});
              }
            },
            child: const Text(
              'פרוייקט חדש',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            itemCount: projectsData.isEmpty ? 1 : projectsData.length,
            itemBuilder: (context, i) {
              if (projectsData.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Text(
                      'הוסף פרוייקט חדש כדי להתחיל (:',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                );
              }

              // print('dummyData ${projectsData[i].projectName}');
              // print('dummyData ${projectsData[i].allUpdates}');
              // print('dummyData ${projectsData[i].timeCreated}');

              var timeCreated = projectsData[i].timeCreated;
              var allUpdates = projectsData[i].allUpdates;
              String timeCreatedStr =
                  timeCreated.isNotEmpty ? timeCreated[0] : '';
              String allUpdatesStr = allUpdates.isNotEmpty ? allUpdates[0] : '';

              return Column(
                key: Key(i.toString()),
                children: [
                  if (i != 0 && false) myDivider,
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 5, right: 10, left: 10),
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          RichText(
                            textDirection: TextDirection.ltr,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: timeCreatedStr,
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black)),
                                TextSpan(
                                    text: ' · ${projectsData[i].projectName}',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () async {
                                bool shouldDelete = await ruSureDialog(
                                        context, projectsData[i].projectName) ??
                                    false;
                                if (shouldDelete) {
                                  projectsData.remove(projectsData[i]);
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.grey,
                                size: 15,
                              )),
                        ],
                      )),
                  buildCard(i, allUpdatesStr),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void goToDetailsPage(i) async {
    ProjectData result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(projectsData[i])),
    );
    // Update project data
    projectsData[i] = result;
    await saveLocally(projectsData);
    setState(() {});
  }

  Card buildCard(int i, String allUpdatesStr) {
    var lastedUpdate = TextEditingController();
    var formatTime = intl.DateFormat("(dd/MM) HH:mm");
    var nowTime = formatTime.format(DateTime.now());
    var fNode = FocusNode();

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
/*      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
        side: BorderSide(
          width: 1,
          color: Colors.grey[400]!, //<-- SEE HERE
        ),
      ),*/
      child: ListTile(
        onTap: () => goToDetailsPage(i),
        title: TextField(
            controller: lastedUpdate,
            focusNode: fNode,
            textInputAction: TextInputAction.newline,
            onEditingComplete: () => fNode.unfocus(),
            onTapOutside: (val) => fNode.unfocus(),
            onChanged: (value) => print('lastedUpdate ${lastedUpdate.text}'),
            style: TextStyle(
                color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
            minLines: 1,
            maxLines: 4,
            decoration: myDeco(
              allUpdatesStr,
            )),
        subtitle: projectsData[i].allUpdates.isEmpty ||
                projectsData[i].allUpdates.length == 1
            ? null
            : Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "${projectsData[i].timeCreated[1]} · ${projectsData[i].allUpdates[1]}",
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                ),
              ),
        leading: Icon(Icons.subject),
        trailing: IconButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.zero,
            onPressed: () {
              print('lastedUpdate.text: ${lastedUpdate.text}');
              if (lastedUpdate.text.isNotEmpty) {
                projectsData[i].allUpdates.insert(0, lastedUpdate.text);
                projectsData[i].timeCreated.insert(0, nowTime);
                saveLocally(projectsData);
                setState(() {});
              } else {
                fNode.requestFocus();
                mySnack(context, 'עלייך לכתוב עדכון חדש');
              }
            },
            icon: Icon(Icons.add_circle_outline)),
      ),
    );
  }
}
