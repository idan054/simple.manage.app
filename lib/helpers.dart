import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manage/projectData.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

InputDecoration myDeco(String hintText,
    {Color hintColor = Colors.black, Widget suffix = const Offstage()}) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
      borderRadius: BorderRadius.circular(5.0),
    ),
    border: InputBorder.none,
    hintStyle:
        TextStyle(color: hintColor, fontSize: 13, fontWeight: FontWeight.bold),
    hintText: hintText,
    suffix: suffix,
  );
}

void mySnack(context, text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 750),
    ));

Future clearLocally() async {
  var pref = await SharedPreferences.getInstance();
  pref.clear();
  var prefData = pref.getString('AllProjectsData');
  print('pref: $prefData');
}

Future<List<ProjectData>> getLocally() async {
  final prefs = await SharedPreferences.getInstance();
  var projectsStr = prefs.getString('AllProjectsData');
  List projectsList = jsonDecode(projectsStr ?? '[]');
  var projectsData =
      projectsList.map((e) => projectDataFromJson(jsonEncode(e))).toList();
  // print('projects Data: ${projectsData.runtimeType}');
  // print('projects Data: $projectsData');
  // print('--------------');

  return projectsData.toList();
}

Future saveLocally(List<ProjectData> data) async {
  final prefs = await SharedPreferences.getInstance();
  print('saveLocally() ${jsonEncode(data)}');
  prefs.setString('AllProjectsData', jsonEncode(data));

  // var itemsAsJson = data.map((e) => e.toJson()).toList();
  // print('itemsAsJson data ${itemsAsJson.runtimeType}');
  // print('itemsAsJson data ${itemsAsJson}');
  //
  // print('--------------------');
  //
  // var projectsData = data.map((e) => projectDataFromJson(jsonEncode(e)));
  // print('projectsData data ${projectsData.runtimeType}');
  // print('projectsData data ${projectsData}');
}
