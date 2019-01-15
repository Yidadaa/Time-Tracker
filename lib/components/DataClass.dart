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

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["created"] = this.created;
    map["color"] = this.color.value;
    map["remark"] = this.remark;
    map["name"] = this.name;

    return map;
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
    this.folder = map["folder"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["created"] = this.created;
    map["color"] = this.color.value;
    map["remark"] = this.remark;
    map["name"] = this.name;
    map["folder"] = this.folder.id;

    return map;
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
    this.activity = map["activity"];
    this.st = map["st"];
    this.ed = map["ed"];
    this.duration = map["duration"];
    this.status = map["status"];
    this.text = map["text"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["activity"] = this.activity.id;
    map["st"] = this.st;
    map["ed"] = this.ed;
    map["duration"] = this.duration;
    map["status"] = this.status;
    map["text"] = this.text;

    return map;
  }
}
