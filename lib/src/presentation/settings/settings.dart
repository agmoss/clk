// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:clk/src/theme/theme_model.dart';
import 'settings_layout.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Color _tempGmtHandColor;
  late Color _tempLumeColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    _tempGmtHandColor = themeModel.gmtHandColor;
    _tempLumeColor = themeModel.lumeColor;
  }

  void _showColorPicker(Color currentColor, Function(Color) onColorSelected) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Select a color'),
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: currentColor,
                  onColorChanged: onColorSelected,
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context, listen: false);

    final chld = themeModel.isDarkMode
        ? [
            ListTile(
                title: const Text('Lume'),
                trailing: Icon(Icons.circle, color: _tempLumeColor),
                onTap: () => _showColorPicker(_tempLumeColor, (color) {
                      setState(() => _tempLumeColor = color);
                      themeModel.setLume(color);
                    }))
          ]
        : [
            ListTile(
              title: const Text('GMT Hand Color'),
              trailing: Icon(Icons.circle, color: _tempGmtHandColor),
              onTap: () => _showColorPicker(_tempGmtHandColor, (color) {
                setState(() => _tempGmtHandColor = color);
                themeModel.setGmtHandColor(color);
              }),
            )
          ];

    return SettingLayout(
      content: Column(children: chld),
    );
  }
}
