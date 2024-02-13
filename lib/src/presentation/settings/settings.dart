import 'package:clk/src/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import 'settings_layout.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Color _tempHourHandColor;
  late Color _tempMinuteHandColor;
  late Color _tempSecondHandColor;
  late Color _tempLumeColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final themeModel = Provider.of<ThemeModel>(context, listen: false);
    _tempHourHandColor = themeModel.hourHandColor;
    _tempMinuteHandColor = themeModel.minuteHandColor;
    _tempSecondHandColor = themeModel.secondHandColor;
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
              title: const Text('Hour Hand Color'),
              trailing: Icon(Icons.circle, color: _tempHourHandColor),
              onTap: () => _showColorPicker(_tempHourHandColor, (color) {
                setState(() => _tempHourHandColor = color);
                themeModel.setHourHandColor(color);
              }),
            ),
            ListTile(
              title: const Text('Minute Hand Color'),
              trailing: Icon(Icons.circle, color: _tempMinuteHandColor),
              onTap: () => _showColorPicker(_tempMinuteHandColor, (color) {
                setState(() => _tempMinuteHandColor = color);
                themeModel.setMinuteHandColor(color);
              }),
            ),
            ListTile(
              title: const Text('Second Hand Color'),
              trailing: Icon(Icons.circle, color: _tempSecondHandColor),
              onTap: () => _showColorPicker(_tempSecondHandColor, (color) {
                setState(() => _tempSecondHandColor = color);
                themeModel.setSecondHandColor(color);
              }),
            )
          ];

    return SettingLayout(
      content: Column(children: chld),
    );
  }
}
