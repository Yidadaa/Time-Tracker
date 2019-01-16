import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";
import "../components/DataClass.dart";

Database db;
String activityTable = "ACTIVITY";
String folderTable = "FOLDER";
String recordTable = "RECORD";

Future initDB() async {
  var dbPath = await getDatabasesPath();
  dbPath = join(dbPath, 'app.db');

  db = await openDatabase(dbPath, version: 1, onCreate: (_db, version) async {
    print("Prepare to init DB.");
    await _db.execute("""
      CREATE TABLE ACTIVITY (
          id      INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
          folder          REFERENCES FOLDER (id),
          color   INTEGER,
          remark  CHAR,
          created INTEGER,
          name    CHAR    NOT NULL
      );
      """);
    await _db.execute("""
      CREATE TABLE FOLDER (
          id      INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
          created INTEGER NOT NULL,
          color   INTEGER,
          remark  CHAR,
          name    CHAR    NOT NULL
      );
      """);
    await _db.execute("""
      CREATE TABLE RECORD (
          id       INTEGER PRIMARY KEY AUTOINCREMENT,
          activity         REFERENCES ACTIVITY (id),
          st       INTEGER,
          ed       INTEGER,
          status   INT     NOT NULL
                          DEFAULT (0),
          text     CHAR,
          duration INTEGER
      );
      """);
    print("Init Database Done!");
  });
}

Future<List<Folder>> getFoldersOf({List ids}) async {
  var result = [];
  if (ids != null && ids.length > 0) {
    String args = List.filled(ids.length, "?").join(",");
    result =
        await db.query(folderTable, where: "id in ($args)", whereArgs: ids);
  } else {
    result = await db.query(folderTable);
  }
  return result.map((v) => Folder.fromMap(v)).toList();
}

Future insertFolder(Folder f) async {
  f.id = await db.insert(folderTable, f.toMap());
  return f;
}

Future updateFolder(Folder f) async {
  f.id = await db.update(folderTable, f.toMap());
  return f;
}

Future<List<Activity>> getActivitiesOf({List ids}) async {
  var result = [];
  if (ids != null && ids.length > 0) {
    String args = List.filled(ids.length, "?").join(",");
    result =
        await db.query(activityTable, where: "id in ($args)", whereArgs: ids);
  } else {
    result = await db.query(activityTable);
  }
  // Convert query result to mutable map.
  var _res = result.map((v) => Map<String, dynamic>.from(v)).toList();
  // Get id of folders.
  List folderIds = _res.map((v) => v["folder"]).toList();
  // Query folders.
  List<Folder> folders = await getFoldersOf(ids: folderIds);
  // Index foldres.
  Map indexFolder =
      Map.fromIterable(folders, key: (v) => v.id, value: (v) => v);
  // Replace folder id in activities with folder map.
  for (int i = 0; i < _res.length; i++) {
    _res[i]["folder"] = indexFolder[_res[i]["folder"]];
  }

  List acitivities = _res.map((v) => Activity.fromMap(v)).toList();
  return acitivities;
}

Future insertActivity(Activity a) async {
  a.id = await db.insert(activityTable, a.toMap());
  return a;
}

Future updateActivity(Activity a) async {
  a.id = await db.update(activityTable, a.toMap());
  return a;
}

// Records CURD Function

// Turn activity fielld of query records to activity class.
Future<List> getActivitiesOfRecords(List rawRecords) async {
  // Same as getActivitiesOf
  var _res = rawRecords.map((v) => Map<String, dynamic>.from(v)).toList();
  List activityIds = _res.map((v) => v["activity"]).toList();
  List<Activity> activities = await getActivitiesOf(ids: activityIds);
  Map indexActivity =
      Map.fromIterable(activities, key: (v) => v.id, value: (v) => v);
  for (int i = 0; i < _res.length; i++) {
    _res[i]["activity"] = indexActivity[_res[i]["activity"]];
  }
  return _res;
}

// Get all record items.
Future<List<Record>> getAllRecords() async {
  var result = await db.query(recordTable);
  var _res = await getActivitiesOfRecords(result);
  return _res.map((v) => Record.fromMap(v)).toList();
}

// Get records between date.
Future<List<Record>> getRecordsBetween(int from, int to) async {
  var result = await db
      .query(recordTable, where: "st > ? and ed < ?", whereArgs: [from, to]);
  var _res = await getActivitiesOfRecords(result);
  return _res.map((v) => Record.fromMap(v)).toList();
}

Future insertRecord(Record r) async {
  r.id = await db.insert(recordTable, r.toMap());
  return r;
}

Future updateRecord(Record r) async {
  r.id = await db.update(recordTable, r.toMap());
  return r;
}
