// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:clk/src/routes/routes.dart';
import 'package:clk/src/theme/theme_model.dart';

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
                    initialRoute: Routes.clock,
                    onGenerateRoute: RouterGenerator.generateRoutes,
                  )),
        ),
      );
}
