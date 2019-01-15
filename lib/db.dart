import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

Database db;

Future initDB() async {
  var dbPath = await getDatabasesPath();
  dbPath = join(dbPath, 'app.db');

  db = await openDatabase(dbPath, version: 1, onCreate: (db, version) async {
    print("Prepare to init DB.");
    await db.execute("""
      PRAGMA foreign_keys = off;
      BEGIN TRANSACTION;

      -- 表：ACTIVITY
      CREATE TABLE ACTIVITY (
          id      INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
          folder          REFERENCES FOLDER (id),
          color   CHAR,
          remark  CHAR,
          created INTEGER,
          name    CHAR    NOT NULL
      );


      -- 表：FOLDER
      CREATE TABLE FOLDER (
          id      INTEGER PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
          created INTEGER NOT NULL,
          color   CHAR,
          remark  CHAR,
          name    CHAR    NOT NULL
      );


      -- 表：RECORD
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


      COMMIT TRANSACTION;
      PRAGMA foreign_keys = on;

      """);
    print("Init Database Done!");
  });
}
