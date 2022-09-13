// To parse this JSON data, do
//
//     final projectData = projectDataFromJson(jsonString);


import 'dart:convert';

ProjectData projectDataFromJson(String str) => ProjectData.fromJson(json.decode(str));

String projectDataToJson(ProjectData data) => json.encode(data.toJson());

class ProjectData {
  ProjectData({
    required this.projectName,
    required this.timeCreated,
    required this.allUpdates,
  });

  String projectName;
  List<String> timeCreated;
  List<String> allUpdates;

  ProjectData copyWith({
    String? projectName,
    List<String>? timeCreated,
    List<String>? allUpdates,
  }) =>
      ProjectData(
        projectName: projectName ?? this.projectName,
        timeCreated: timeCreated ?? this.timeCreated,
        allUpdates: allUpdates ?? this.allUpdates,
      );

  factory ProjectData.fromJson(Map<String, dynamic> json) => ProjectData(
    projectName: json["projectName"],
    timeCreated: List<String>.from(json["timeCreated"].map((x) => x)),
    allUpdates: List<String>.from(json["allUpdates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "projectName": projectName,
    "timeCreated": List<dynamic>.from(timeCreated.map((x) => x)),
    "allUpdates": List<dynamic>.from(allUpdates.map((x) => x)),
  };
}
