import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final Function onColorChanged;

  ColorSelector({this.onColorChanged}) : super();

  _ColorSelectorState createState() => _ColorSelectorState(onColorChanged);
}

class _ColorSelectorState extends State<ColorSelector> {
  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.deepOrange,
    Colors.orange,
    Colors.red,
    Colors.amber
  ];
  Color selectedColor = Colors.green;
  Function onChange;

  _ColorSelectorState(this.onChange);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Row(
          children: colors
              .map((v) => Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () {
                        this.onChange(v);
                        setState(() {
                          selectedColor = v;
                        });
                      },
                      child: Container(
                          height: 30.0,
                          width: 30.0,
                          child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100.0),
                                    color: v),
                                child: Center(
                                    child: Icon(Icons.check,
                                        color: v.value == selectedColor.value
                                            ? Colors.white
                                            : Colors.transparent)),
                              ))),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
