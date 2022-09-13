
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

InputDecoration myDeco(String hintText, {Color hintColor = Colors.black}) =>
InputDecoration(
  focusedBorder: OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey[400]!, width: 2.0),
  borderRadius: BorderRadius.circular(5.0),
  ),
  border: InputBorder.none,
  hintStyle: TextStyle(color: hintColor),
  hintText: hintText
);