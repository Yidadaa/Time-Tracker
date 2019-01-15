import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BarData {
  final double from;
  final double to;
  final Color color;

  BarData(this.from, this.to, this.color);
}

class BarPainter extends CustomPainter {
  final double height;
  final Color color;
  final List<BarData> data;

  BarPainter(this.height, this.color, this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double centerHeight = size.height / 2;

    data.insert(0, BarData(0, 1, Color(0xFFFEFEFE)));

    data.forEach((v) {
      Offset _start = new Offset(v.from * size.width, centerHeight);
      Offset _end = new Offset(v.to * size.width, centerHeight);
      Paint _line = new Paint()
        ..color = v.color
        ..strokeCap = StrokeCap.butt
        ..style = PaintingStyle.fill
        ..strokeWidth = this.height;
      canvas.drawLine(_start, _end, _line);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
