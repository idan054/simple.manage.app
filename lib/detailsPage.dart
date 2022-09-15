import 'package:flutter/material.dart';
import 'package:manage/helpers.dart';
import 'package:manage/projectData.dart';
import 'mainPage.dart';

class DetailsPage extends StatefulWidget {
  final ProjectData projectData;

  const DetailsPage(this.projectData, {Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    ProjectData projectData = widget.projectData;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, projectData); // Go back with this
        return Future.value(false); // Instead this.
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('היסטוריית עדכונים'
                ' · '
                '${projectData.projectName}'),
          ),
          body: ListView.builder(
            itemCount: projectData.allUpdates.length,
            itemBuilder: (context, i) {
              var updateNote = projectData.allUpdates[i];
              var timeCreated = projectData.timeCreated[i];

              var noteController = TextEditingController(text: updateNote);
              var noteNode = FocusNode();
              return StatefulBuilder(
                builder: (context, stfSetState) {
                  return Card(
                    child: ListTile(
                      title: TextField(
                        focusNode: noteNode,
                        controller: noteController,
                        onTap: () => stfSetState(() {}),
                        onChanged: (val) => stfSetState(() {}),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
                        minLines: 1,
                        maxLines: 20,
                        decoration: myDeco(''),
                      ),
                      subtitle: Text(timeCreated),
                     trailing: InkWell(
                                  onTap: () {
                                    if (noteController.text == updateNote) {
                                      // Delete option:
                                      projectData.allUpdates.removeAt(i);
                                      projectData.timeCreated.removeAt(i);
                                      setState(() {});

                                    } else {
                                      // Edit option:
                                      projectData.allUpdates[i] = noteController.text;
                                      noteNode.unfocus();
                                      setState(() {});
                                    }
                                  },
                                  child: Icon(
                                      noteController.text == updateNote ? Icons.close : Icons.task_alt))
                    ),
                  );
                }
              );
            },
          ),
        ),
      ),
    );
  }
}
