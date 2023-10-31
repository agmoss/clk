import 'dart:async';
import 'package:flutter/material.dart';

import 'clock_painter.dart';
import 'layout.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        content: SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: CustomPaint(
        painter: ClockPainter(
          hourHandColor: Theme.of(context).colorScheme.primary,
          minuteHandColor: Theme.of(context).colorScheme.secondary,
          secondHandColor: Theme.of(context).colorScheme.tertiary,
          dialColor: Theme.of(context).colorScheme.surface,
          markerColor: Theme.of(context).colorScheme.outline,
        ),
      ),
    ));
  }
}
