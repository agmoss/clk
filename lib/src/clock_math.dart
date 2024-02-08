import 'dart:math';
import 'package:flutter/material.dart';

class ClockMath {
  Offset calculateHandOffset(DateTime now, String handType, double length) {
    double degree;

    switch (handType) {
      case 'hour':
        degree = hourDegree(now);
        break;
      case 'minute':
        degree = minuteDegree(now);
        break;
      case 'second':
        degree = secondDegree(now);
        break;
      case 'gmt':
        degree = gmtDegree(now);
        break;
      default:
        throw ArgumentError(
            'Invalid hand type provided to calculateHandOffset');
    }

    return Offset(
        length * sin(radians(degree)), -length * cos(radians(degree)));
  }

  double radians(double degree) => degree * (pi / 180);

  Offset handPosition(double degree, double length, Offset center) {
    final double radians = this.radians(degree - 90);
    return Offset(
        center.dx + cos(radians) * length, center.dy + sin(radians) * length);
  }

  double hourDegree(DateTime now) => 360 / 12 * (now.hour + now.minute / 60);

  double minuteDegree(DateTime now) =>
      360 / 60 * (now.minute + now.second / 60);

  double secondDegree(DateTime now) => 360 / 60 * now.second;

  double gmtDegree(DateTime now) {
    DateTime utcNow = now.toUtc();
    return 360 / 24 * (utcNow.hour + utcNow.minute / 60 + utcNow.second / 3600);
  }
}
