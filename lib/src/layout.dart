import 'package:clk/src/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Layout extends StatelessWidget {
  final Widget content;

  const Layout({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              color: Theme.of(context).colorScheme.error,
              icon: const Icon(Icons.light_mode),
              onPressed: () {
                Provider.of<ThemeModel>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
        body: SafeArea(child: Center(child: content)));
  }
}
