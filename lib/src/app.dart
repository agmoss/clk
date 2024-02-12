import 'package:clk/src/clock.dart';
import 'package:clk/src/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeModel(),
        child: Consumer<ThemeModel>(
          builder: (context, theme, child) => FlutterSizer(
              builder: (context, orientation, screenType) => MaterialApp(
                    title: 'clk',
                    restorationScopeId: 'app',
                    debugShowCheckedModeBanner: false,
                    theme: theme.currentTheme,
                    home: const Clock(),
                  )),
        ),
      );
}
