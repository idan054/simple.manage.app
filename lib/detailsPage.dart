import 'package:flutter/material.dart';
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('היסטוריית עדכונים'
              ' · '
              '${widget.projectData.projectName}'),
        ),
        body: ListView.builder(
          itemCount: widget.projectData.allUpdates.length,
          itemBuilder: (context, i) {
            var updateNote = widget.projectData.allUpdates[i];
            var timeCreated = widget.projectData.timeCreated[i];
            return Card(
              child: ListTile(
                title: Text(updateNote),
                subtitle: Text(timeCreated),
              ),
            );
          },
        ),
      ),
    );
  }
}
