import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manage/mainPage.dart';
import 'package:manage/projectData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'helpers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('START main()!');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print('START');
  // SharedPreferences.setMockInitialValues({'AllProjectsData' : '[{"projectName":"Pogo","timeCreated":["עכשיו","אתמול","לפני 2 ימים"],"allUpdates":["עדכון פוגו ראשון","עדכון פוגו שני","עדכון פוגו שלישי"]},{"projectName":"AllerG","timeCreated":["עכשיו","אתמול","לפני 2 ימים"],"allUpdates":["עדכון AllerG ראשון","עדכון AllerG שני","עדכון AllerG שלישי"]}]'});
  // SharedPreferences.setMockInitialValues({});
  // List<ProjectData> projectsData = await getLocally();
  // List<ProjectData> projectsData = [];
  var projectsData = await loadProjects();
  print('getLocally() PROJECTS result: ${projectsData.length}');
  runApp(myApp(projectsData));
}

Widget myApp(projectsData) => MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: MainPage(projectsData)),
    );
