import 'package:flutter/material.dart';
import 'utils/db.dart';
import 'pages/HomePage.dart';
import 'pages/NewFolder.dart';
import 'pages/SummaryPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'time tracker',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new LogicPage(),
      routes: {
        '/new-folder': (context) => NewFolderPage(),
        '/summary': (context) => SummaryPage()
      },
    );
  }
}

class LogicPage extends StatefulWidget {
  LogicPage({Key key}) : super(key: key);

  @override
  _LogicPageState createState() => new _LogicPageState();
}

class _LogicPageState extends State<LogicPage> with WidgetsBindingObserver {
  void firstStart() async {
    await initDB();
  }

  @override
  void initState() {
    super.initState();
    this.firstStart();
  }

  @override
  Widget build(BuildContext context) {
    return new HomePage();
  }
}
