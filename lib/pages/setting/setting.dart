import "package:flutter/material.dart";
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:gitme/components/setting/theme_option.dart';
import 'package:gitme/constants/languages.dart';
import 'package:gitme/constants/themes.dart';
import 'package:gitme/stores/setting.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingModel>(context);
    Locale currentLang = FlutterI18n.currentLocale(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterI18n.translate(context, "nav.setting")),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: Icon(Icons.palette),
            title: Text(FlutterI18n.translate(context, "setting.theme")),
            children: <Widget>[
              Wrap(
                spacing: 8.0,
                children: <Widget>[
                  ThemeOption(
                    color: Colors.blue,
                    onPress: () => setting.changeTheme(AppLightTheme.Blue),
                  ),
                  ThemeOption(
                    color: Colors.blueGrey,
                    onPress: () => setting.changeTheme(AppLightTheme.BlueGrey),
                  ),
                  ThemeOption(
                    color: Colors.brown,
                    onPress: () => setting.changeTheme(AppLightTheme.Brown),
                  ),
                ],
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(FlutterI18n.translate(context, "setting.language")),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(localeLangStrMap[currentLang.toString()]),
                Icon(Icons.keyboard_arrow_right),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushNamed("/setting/language");
            },
          ),
        ],
      ),
    );
  }
}
