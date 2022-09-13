import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manage/projectData.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

InputDecoration myDeco(String hintText, {Color hintColor = Colors.black}) =>
    InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
        border: InputBorder.none,
        hintStyle: TextStyle(color: hintColor),
        hintText: hintText);

void mySnack(context, text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: Duration(milliseconds: 750),
    ));

Future saveLocally(List<ProjectData> data) async {
  // final prefs = await SharedPreferences.getInstance();
  // prefs.setString('AllProjectsData', data.map((e) => e.toJson()));

  var itemsAsJson = data.map((e) => e.toJson()).toList();
  print('itemsAsJson data ${itemsAsJson.runtimeType}');
  print('itemsAsJson data ${itemsAsJson}');

  print('--------------------');

  var projectsData = data.map((e) => projectDataFromJson(jsonEncode(e)));
  print('projectsData data ${projectsData.runtimeType}');
  print('projectsData data ${projectsData}');
}
