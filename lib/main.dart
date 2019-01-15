import 'package:flutter/material.dart';
import 'components/BarPainter.dart';
import 'db.dart';
import 'components/DataClass.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "上午好";
  final _theKey = GlobalKey<ScaffoldState>();
  final testData = [
    new BarData(0.1, 0.2, Colors.grey),
    new BarData(0.2, 0.4, Colors.green),
    new BarData(0.43, 0.5, Colors.blue),
    new BarData(0.53, 0.6, Colors.red),
    new BarData(0.63, 0.9, Colors.redAccent)
  ];

  @override
  void initState() {
    super.initState();
    initDB();
  }

  void testDB() async {
    print("Test FolderTable");
    var testFolder = new Folder(
        created: new DateTime.now().microsecondsSinceEpoch,
        color: Colors.green,
        remark: "ss",
        name: "test");
    await insertFolder(testFolder);
    var res = await getFoldersOf();
    res.forEach((v) => print(v.toMap()));

    print("Test ActivityTable");

    await insertActivity(new Activity(
        created: new DateTime.now().microsecondsSinceEpoch,
        color: Colors.grey,
        remark: "test",
        name: "hello",
        folder: testFolder));
    var aRes = await getActivitiesOf();
    aRes.forEach((v) => print(v.toMap()));
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration cardDecoration = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, offset: Offset(0.0, 0.0), blurRadius: 10.0)
        ]);

    TextStyle boldStyle =
        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
    TextStyle boldTitleStyle =
        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);
    Expanded block = Expanded(
        child: Container(
      decoration: cardDecoration,
      padding:
          new EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("非必要活动"),
              Container(
                height: 10.0,
                width: 10.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.green),
              )
            ],
          ),
          Text("睡觉", style: boldStyle),
          Divider(
            color: Colors.black12,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text("08:03", style: boldStyle),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Icon(Icons.pause),
                ),
              )
            ],
          )
        ],
      ),
    ));
    return new Scaffold(
        key: _theKey,
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("主页")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart), title: Text("汇总")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text("设置"))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            testDB();
          },
        ),
        body: ListView(
          padding: new EdgeInsets.all(20.0),
          children: <Widget>[
            Container(
                margin: new EdgeInsets.only(top: 40.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )),
            Container(
                margin: new EdgeInsets.only(top: 30.0, bottom: 40.0),
                decoration: cardDecoration,
                child: Material(
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text("今日概览"),
                                  ),
                                  Text("2019/01/12")
                                ],
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  color: Colors.grey,
                                  margin: new EdgeInsets.only(
                                      top: 20.0, bottom: 20.0),
                                  child: CustomPaint(
                                    foregroundPainter:
                                        BarPainter(12.0, Colors.grey, testData),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("已记录"),
                                      Text(
                                        "5h 40min",
                                        style: boldStyle,
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("最耗时"),
                                      Text(
                                        "睡觉、工作",
                                        style: boldStyle,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )))),
            Text(
              "选择一项活动开始记录",
              style: boldTitleStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Column(
                  children: List.generate(4, (index) {
                return Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: <Widget>[
                      block,
                      Container(
                        width: 10.0,
                      ),
                      block
                    ],
                  ),
                );
              })),
            )
          ],
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
