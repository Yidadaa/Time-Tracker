import 'package:flutter/rendering.dart';

class Folder {
  int id;
  int created;
  Color color;
  String remark;
  String name;

  Folder({this.id, this.created, this.color, this.remark, this.name});

  Folder.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.created = map["created"];
    this.color = Color(map["color"]);
    this.remark = map["remark"];
    this.name = map["name"];
  }
}

class Activity {
  int id;
  int created;
  Color color;
  String remark;
  String name;
  Folder folder;

  Activity(
      {this.id, this.created, this.color, this.remark, this.name, this.folder});

  Activity.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.created = map["created"];
    this.color = Color(map["color"]);
    this.remark = map["remark"];
    this.name = map["name"];
    this.folder = Folder.fromMap(map["folder"]);
  }
}

class Record {
  int id;
  Activity activity;
  int st;
  int ed;
  int status;
  String text;
  int duration;

  Record(
      {this.id,
      this.activity,
      this.st,
      this.ed,
      this.duration,
      this.status,
      this.text});

  Record.fromMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.activity = Activity.fromMap(map["activity"]);
    this.st = map["st"];
    this.ed = map["ed"];
    this.duration = map["duration"];
    this.status = map["status"];
    this.text = map["text"];
  }
}
