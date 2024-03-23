// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:clk/src/routes/routes.dart';
import 'package:clk/src/theme/theme.dart';
import 'package:clk/src/theme/theme_model.dart';

class ClockLayout extends StatelessWidget {
  final Widget content;

  const ClockLayout({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: null,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            color: Theme.of(context).colorScheme.altColor,
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              Provider.of<ThemeModel>(context, listen: false).toggleTheme();
            },
          ),
          IconButton(
            color: Theme.of(context).colorScheme.altColor,
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Routes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
              child: Padding(
        padding: EdgeInsets.fromLTRB(2.h, 2.w, 2.h, 2.w),
        child: content,
      ))));
}
