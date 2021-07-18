import "package:flutter/material.dart";
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:gitme/constants/languages.dart';
import 'package:gitme/stores/setting.dart';
import 'package:provider/provider.dart';

class SettingLanguagePage extends StatefulWidget {
  @override
  _SettingLanguagePageState createState() => _SettingLanguagePageState();
}

class _SettingLanguagePageState extends State<SettingLanguagePage> {
  late SettingModel setting;

  @override
  Widget build(BuildContext context) {
    setting = Provider.of<SettingModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            FlutterI18n.translate(context, "setting.language"),
          ),
        ),
        body: ListView(
          children: <Widget>[
            RadioListTile(
              title: Text("English"),
              value: Language.english,
              groupValue: setting.language,
              onChanged: _changeLang,
            ),
            RadioListTile(
                title: Text("繁體中文"),
                value: Language.traditionalChinese,
                groupValue: setting.language,
                onChanged: _changeLang),
          ],
        ));
  }

  Future<void> _changeLang(Language? changedLang) async {
    setting.changeLanguage(changedLang!);
    await FlutterI18n.refresh(context, Locale('zh', 'TW'));

    // showNotify(
    //   message: FlutterI18n.translate(
    //     context,
    //     "setting.switchLangMsg",
    //     translationParams: {"lang": langLocaleMap[changedLang].toString()},
    //   ),
    // );
  }
}
