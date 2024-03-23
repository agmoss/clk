// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:clk/src/theme/theme.dart';
import 'clock_layout.dart';
import 'clock_painter.dart';

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
  Widget build(BuildContext context) => ClockLayout(
          content: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: CustomPaint(
          painter: ClockPainter(
            handColor: Theme.of(context).colorScheme.getHandColor,
            dialColor: Theme.of(context).colorScheme.getDialColor,
            markerColor: Theme.of(context).colorScheme.getMarkerColor,
            gmtHandColor: Theme.of(context).colorScheme.getGmtHandColor,
          ),
        ),
      ));
}
