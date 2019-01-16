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
              .map((v) => Container(
                  height: 30.0,
                  width: 30.0,
                  margin: EdgeInsets.only(right: 10.0),
                  child: ButtonTheme(
                    padding: EdgeInsets.all(0.0),
                    child: RaisedButton(
                      onPressed: () {
                        this.onChange(v);
                        setState(() {
                          selectedColor = v;
                        });
                      },
                      child: Icon(
                        Icons.check,
                        color: selectedColor.value == v.value
                            ? Colors.white
                            : Colors.transparent,
                        size: 20.0,
                      ),
                      color: v,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                    ),
                  )))
              .toList(),
        ),
      ),
    );
  }
}
