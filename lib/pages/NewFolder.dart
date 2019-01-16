import 'package:flutter/material.dart';
import '../components/DataClass.dart';
import '../components/ColorSelector.dart';
import '../utils/db.dart';

class NewFolderPage extends StatefulWidget {
  @override
  _NewFolderPageState createState() => _NewFolderPageState();
}

class _NewFolderPageState extends State<NewFolderPage> {
  String title;
  Color color = Colors.green;

  final titleController = TextEditingController();
  final remarkController = TextEditingController();

  void onColorChanged(Color newColor) {
    setState(() {
      color = newColor;
    });
  }

  void onCreateNewFolder() async {
    Folder newFolder = Folder()
      ..name = titleController.text
      ..color = color
      ..remark = remarkController.text
      ..created = DateTime.now().millisecondsSinceEpoch;
    Folder savedFolder = await insertFolder(newFolder);

    bool result = savedFolder.id != null;
    if (result) {
      Navigator.pop(context, savedFolder);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = new ThemeData(primaryColor: color);
    TextStyle titleStyle =
        TextStyle(color: theme.primaryTextTheme.title.color, fontSize: 24.0);

    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "新建分类",
            style: theme.primaryTextTheme.title,
          ),
          elevation: 0.0,
          backgroundColor: color,
          iconTheme: theme.primaryIconTheme,
          actions: <Widget>[
            FlatButton(
              onPressed: onCreateNewFolder,
              child: Icon(
                Icons.save,
                color: theme.primaryIconTheme.color,
                semanticLabel: "保存",
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: ColorSelector(onColorChanged: this.onColorChanged),
              )
            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              color: color,
              child: TextField(
                  controller: titleController,
                  style: titleStyle,
                  decoration: InputDecoration(
                    hintText: "输入分类标题",
                    border: InputBorder.none,
                    hintStyle: theme.inputDecorationTheme.hintStyle,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: remarkController,
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
                maxLines: null,
                decoration: InputDecoration(
                    hintText: "描述",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.black54)),
              ),
            )
          ],
        ));
  }
}
