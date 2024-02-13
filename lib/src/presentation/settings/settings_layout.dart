import 'package:clk/src/routes/routes.dart';
import 'package:clk/src/theme/theme.dart';
import 'package:flutter/material.dart';

class SettingLayout extends StatelessWidget {
  final Widget content;

  const SettingLayout({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          color: Theme.of(context).colorScheme.altColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, Routes.clock);
          },
        ),
      ),
      body: SafeArea(child: content));
}
