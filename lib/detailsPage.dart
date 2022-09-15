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
              return Card(
                child: ListTile(
                  title: Text(updateNote),
                  subtitle: Text(timeCreated),
                  trailing: InkWell(
                      onTap: () {
                        projectData.allUpdates.removeAt(i);
                        projectData.timeCreated.removeAt(i);
                        setState(() {});
                      },
                      child: const Icon(Icons.close)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
