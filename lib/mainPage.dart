// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

class ProjectData {
  String? projectName;
  List<String> timeCreated = [];
  List<String> allUpdates = [];

  ProjectData(
      {this.projectName, required this.timeCreated, required this.allUpdates});
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<ProjectData> dummyData = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('הפרוייקטים שלי'),
        leading: TextButton(
          onPressed: () {},
          child: const Text('פרוייטק חדש'),
        ),
      ),
      body: ListView.builder(
        itemCount: dummyData.length,
        itemBuilder: (context, i) {
          print('dummyData ${dummyData[i].projectName}');
          print('dummyData ${dummyData[i].allUpdates}');
          print('dummyData ${dummyData[i].timeCreated}');

          return Column(
            children: [
              if (i != 0)
                const Divider(
                    thickness: 1,
                    color: Colors.black12,
                    indent: 15,
                    endIndent: 15),
              Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 5, right: 10),
                  alignment: Alignment.centerRight,
                  child:
                  RichText(
                    textDirection: TextDirection.ltr,
                    text: TextSpan(
                      children: <TextSpan> [
                         TextSpan(text: dummyData[i].timeCreated[0], style: TextStyle(
                             fontSize: 13 )),
                        TextSpan(text: ' · ${dummyData[i].projectName}',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),)

              ),
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
                dummyData[i].allUpdates.insert(0, lastedUpdate.text);
                dummyData[i].timeCreated.insert(0, nowTime);
                setState(() {});
              }
            },
            child: Icon(Icons.add)),
        title: TextField(
          controller: lastedUpdate,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black),
              hintText: dummyData[i].allUpdates![0]),
        ),
        subtitle: Text(
            "${dummyData[i].timeCreated[1]} · ${dummyData[i].allUpdates[1]}",
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
        ),
        trailing: InkWell(onTap: () {}, child: Icon(Icons.menu)),
      ),
    );
  }
}
