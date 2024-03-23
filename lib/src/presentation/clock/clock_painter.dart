// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_sizer/flutter_sizer.dart';

// Project imports:
import 'package:clk/src/math/clock_math.dart';

class ClockPainter extends CustomPainter {
  final Color handColor;

  final Color dialColor;
  final Color markerColor;
  final Color gmtHandColor;

  ClockPainter(
      {required this.handColor,
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
    final double smallCircleRadius = radius * 0.03;
    final paintCenterCircle = Paint()
      ..color = markerColor
      ..isAntiAlias = true;

    canvas.drawCircle(center, smallCircleRadius, paintCenterCircle);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final double markerWidth = radius * 0.05;
    final double markerWidth2 = radius * 0.15;
    final double markerWidth3 = radius * 0.11;
    final paintTick = Paint()
      ..color = markerColor
      ..strokeWidth = markerWidth
      ..isAntiAlias = true;

    for (int i = 0; i < 12; i++) {
      final double tickDegree = i * 30;

      // Determine the tick position
      final tickPosition =
          _clockMath.handPosition(tickDegree, radius - markerWidth, center);

      final tickPosition2 =
          _clockMath.handPosition(tickDegree, radius - markerWidth2, center);

      final tickPosition3 =
          _clockMath.handPosition(tickDegree, radius - markerWidth3, center);

      if (i == 3) {
        _drawDateWindow(canvas, tickPosition2);
        continue;
      }
      if (i % 3 == 0) {
        canvas.drawLine(tickPosition, tickPosition2, paintTick);
      } else {
        // Draw circle ticks for other positions
        canvas.drawCircle(tickPosition3, markerWidth * 0.7,
            paintTick); // Adjust the circle's radius as needed
      }
    }
  }

  void _drawHands(Canvas canvas, Offset center, double radius) {
    final DateTime now = DateTime.now();

    final double hourHandWidth = radius * 0.03;
    final double minuteHandWidth = radius * 0.02;
    final double secondHandWidth = radius * 0.01;
    final double gmtHandWidth = radius * 0.04;

    final double hourHandLength = radius * 0.6;
    final double minuteHandLength = radius * 0.95;
    final double secondHandLength = radius * 0.99;
    final double gmtHandLength = radius * 0.7;

    _drawHand(canvas, center, HandType.hour, handColor, hourHandWidth,
        hourHandLength, now);
    _drawHand(canvas, center, HandType.minute, handColor, minuteHandWidth,
        minuteHandLength, now);
    _drawHand(canvas, center, HandType.second, handColor, secondHandWidth,
        secondHandLength, now);
    _drawHand(canvas, center, HandType.gmt, gmtHandColor, gmtHandWidth,
        gmtHandLength, now);
  }

  void _drawHand(Canvas canvas, Offset center, HandType handType, Color color,
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

    // ignore: cascade_invocations
    textPainter.layout();
    // ignore: cascade_invocations
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
