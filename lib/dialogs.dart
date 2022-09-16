// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'helpers.dart';

Future<String?> newProjDialog(context, {bool isNewProj = true}) async {
  var nameController = TextEditingController();

  return showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Text(isNewProj ? 'הוסף פרוייקט חדש' : '', style: TextStyle(fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: myDeco(isNewProj ?
                        'בחר שם לפרוייקט:' : 'הדבק כאן את המידע',
                        hintColor: Colors.grey),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ביטול'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('הוסף'),
              onPressed: () {
                Navigator.pop(context, nameController.text);
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<bool?> ruSureDialog(context, String projectName) async {
  var nameController = TextEditingController();

  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('אתה בטוח שאתה מעוניין למחוק?', style: TextStyle(fontWeight: FontWeight.bold),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: myDeco('היסטוריית פרוייקט '
                      '$projectName' ' ימחק לתמיד.', hintColor: Colors.red[700]!),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ביטול'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('מחק'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ),
      );
    },
  );
}