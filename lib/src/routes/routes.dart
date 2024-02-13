import 'package:clk/src/presentation/clock/clock.dart';
import 'package:clk/src/presentation/settings/settings.dart';
import 'package:flutter/material.dart';

class Routes {
  static const clock = '/clock';
  static const settings = '/settings';
}

class RouterGenerator {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.clock:
        return MaterialPageRoute(
          builder: ((context) => const Clock()),
        );
      case Routes.settings:
        return MaterialPageRoute(
          builder: ((context) => const Settings()),
        );
      default:
        return MaterialPageRoute(
          builder: ((context) => const Clock()),
        );
    }
  }
}
