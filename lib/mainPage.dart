// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:manage/detailsPage.dart';
import 'package:manage/helpers.dart';
import 'package:manage/projectData.dart';

import 'dialog.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

bool useDummyData = kDebugMode && true;

class _MainPageState extends State<MainPage> {
  List<ProjectData> projectsData = useDummyData ? [
    ProjectData(
      projectName: "Pogo",
      allUpdates: [
        "עדכון פוגו ראשון",
        "עדכון פוגו שני",
        "עדכון פוגו שלישי",
      ],
      timeCreated: [
        "עכשיו",
        "אתמול",
        "לפני 2 ימים",
      ],
    ),
    ProjectData(
      projectName: "AllerG",
      allUpdates: [
        "עדכון AllerG ראשון",
        "עדכון AllerG שני",
        "עדכון AllerG שלישי",
      ],
      timeCreated: [
        "עכשיו",
        "אתמול",
        "לפני 2 ימים",
      ],
    ),
  ] : [];

  @override
  Widget build(BuildContext context) {
    print('Build main page');

    return Scaffold(
      appBar: AppBar(
        title: const Text('הפרוייקטים שלי'),
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
              setState(() {});
            }
          },
          child: const Text(
            'פרוייטק חדש',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: projectsData.isEmpty ? 1 : projectsData.length,
        itemBuilder: (context, i) {
          if (projectsData.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250,),
                Text('הוסף פרוייקט חדש כדי להתחיל (:',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            );
          }

          print('dummyData ${projectsData[i].projectName}');
          print('dummyData ${projectsData[i].allUpdates}');
          print('dummyData ${projectsData[i].timeCreated}');

          return Column(
            children: [
              if (i != 0)
                const Divider(
                    thickness: 1,
                    color: Colors.black12,
                    indent: 15,
                    endIndent: 15),
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
                                text: projectsData[i].timeCreated[0],
                                style: TextStyle(fontSize: 13, color: Colors.black)),
                            TextSpan(
                                text: ' · ${projectsData[i].projectName}',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold)),
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
              buildCard(i),
            ],
          );
        },
      ),
    );
  }

  Card buildCard(int i) {
    var lastedUpdate = TextEditingController();
    var formatTime = intl.DateFormat("(dd/MM) HH:mm");
    var nowTime = formatTime.format(DateTime.now());

    return Card(
      child: ListTile(
        leading: InkWell(
            onTap: () {
              if (lastedUpdate.text.isNotEmpty) {
                projectsData[i].allUpdates.insert(0, lastedUpdate.text);
                projectsData[i].timeCreated.insert(0, nowTime);
                setState(() {});
              } else{
                mySnack(context, 'עלייך לכתוב עדכון חדש');
              }
            },
            child: Icon(Icons.add)),
        title: TextField(
            controller: lastedUpdate,
            decoration: myDeco(projectsData[i].allUpdates[0])),
        subtitle: projectsData[i].timeCreated.length == 1
            ? null
            : Text(
                "${projectsData[i].timeCreated[1]} · ${projectsData[i].allUpdates[1]}",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.right,
              ),
        trailing: InkWell(onTap: () =>
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailsPage(projectsData[i])),
            )
            , child: Icon(Icons.menu)),
      ),
    );
  }
}
