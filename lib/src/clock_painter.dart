import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'clock_math.dart';

class ClockPainter extends CustomPainter {
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color dialColor;
  final Color markerColor;
  final Color gmtHandColor;

  ClockPainter(
      {required this.hourHandColor,
      required this.minuteHandColor,
      required this.secondHandColor,
      required this.dialColor,
      required this.markerColor,
      required this.gmtHandColor});

  final ClockMath _clockMath = ClockMath();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    _drawCircle(canvas, center, radius);
    _drawTicks(canvas, center, radius);
    _drawHands(canvas, center, radius);
    _drawSmallCircle(canvas, center, radius);
  }

  void _drawCircle(Canvas canvas, Offset center, double radius) {
    final paintCircle = Paint()
      ..color = dialColor
      ..isAntiAlias = true;

    canvas.drawCircle(center, radius, paintCircle);
  }

  void _drawSmallCircle(Canvas canvas, Offset center, double radius) {
    double smallCircleRadius = radius * 0.03;
    final paintCenterCircle = Paint()
      ..color = markerColor
      ..isAntiAlias = true;

    canvas.drawCircle(center, smallCircleRadius, paintCenterCircle);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    double markerWidth = radius * 0.05;
    double markerLength = radius * 0.1;
    final paintTick = Paint()
      ..color = markerColor
      ..strokeWidth = markerWidth
      ..isAntiAlias = true;

    for (int i = 0; i < 12; i++) {
      final double tickDegree = i * 30;
      if (i == 3) {
        _drawDateWindow(canvas,
            _clockMath.handPosition(tickDegree, radius - markerLength, center));
        continue;
      }

      final tickPosition =
          _clockMath.handPosition(tickDegree, radius - markerLength, center);
      canvas.drawLine(tickPosition,
          _clockMath.handPosition(tickDegree, radius, center), paintTick);
    }
  }

  void _drawHands(Canvas canvas, Offset center, double radius) {
    final DateTime now = DateTime.now();

    double hourHandWidth = radius * 0.03;
    double minuteHandWidth = radius * 0.02;
    double secondHandWidth = radius * 0.01;
    double gmtHandWidth = radius * 0.04;

    double hourHandLength = radius * 0.6;
    double minuteHandLength = radius * 0.95;
    double secondHandLength = radius * 0.99;
    double gmtHandLength = radius * 0.7;

    _drawHand(canvas, center, 'hour', hourHandColor, hourHandWidth,
        hourHandLength, now);
    _drawHand(canvas, center, 'minute', minuteHandColor, minuteHandWidth,
        minuteHandLength, now);
    _drawHand(canvas, center, 'second', secondHandColor, secondHandWidth,
        secondHandLength, now);
    _drawHand(
        canvas, center, 'gmt', gmtHandColor, gmtHandWidth, gmtHandLength, now);
  }

  void _drawHand(Canvas canvas, Offset center, String handType, Color color,
      double strokeWidth, double length, DateTime now) {
    final paintHand = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    final handOffset = _clockMath.calculateHandOffset(now, handType, length);

    final handPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(center.dx + handOffset.dx, center.dy + handOffset.dy);

    canvas.drawPath(handPath, paintHand);
  }

  void _drawDateWindow(Canvas canvas, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: DateTime.now().day.toString(),
        style: TextStyle(
          color: markerColor,
          fontSize: 16.dp,
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
