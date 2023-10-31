import 'dart:math';
import 'package:flutter/material.dart';
import 'clock_math.dart';

class ClockPainter extends CustomPainter {
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color dialColor;
  final Color markerColor;

  ClockPainter({
    required this.hourHandColor,
    required this.minuteHandColor,
    required this.secondHandColor,
    required this.dialColor,
    required this.markerColor,
  });

  final ClockMath _clockMath = ClockMath();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    _drawCircle(canvas, center, radius);
    _drawTicks(canvas, center, radius);
    _drawHands(canvas, center, radius);
    _drawSmallCircle(canvas, center, 8);
  }

  void _drawCircle(Canvas canvas, Offset center, double radius) {
    final paintCircle = Paint()
      ..color = dialColor
      ..isAntiAlias = true;

    canvas.drawCircle(center, radius, paintCircle);
  }

  void _drawSmallCircle(Canvas canvas, Offset center, double radius) {
    final paintCenterCircle = Paint()
      ..color = markerColor
      ..isAntiAlias = true;

    canvas.drawCircle(center, radius, paintCenterCircle);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final paintTick = Paint()
      ..color = markerColor
      ..strokeWidth = 6
      ..isAntiAlias = true;

    for (int i = 0; i < 12; i++) {
      final double tickDegree = i * 30;
      final tickPosition =
          _clockMath.handPosition(tickDegree, radius - 10, center);
      canvas.drawLine(tickPosition,
          _clockMath.handPosition(tickDegree, radius, center), paintTick);
    }
  }

  void _drawHands(Canvas canvas, Offset center, double radius) {
    final DateTime now = DateTime.now();

    _drawHand(canvas, center, 'hour', hourHandColor, 8.0, radius * 0.6, now);
    _drawHand(
        canvas, center, 'minute', minuteHandColor, 5.0, radius * 0.9, now);
    _drawHand(
        canvas, center, 'second', secondHandColor, 3.0, radius * 0.95, now);
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

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
