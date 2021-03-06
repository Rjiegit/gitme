import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitme/constants/languages.dart';
import 'package:gitme/constants/themes.dart';

class SettingModel extends ChangeNotifier {
  ThemeData _themeData = appLightThemeData[AppLightTheme.BlueGrey]!;
  Language _language = Language.english;

  ThemeData get theme => _themeData;

  Language get language => _language;

  changeTheme(themeData) {
    _themeData = appLightThemeData[themeData]!;
    notifyListeners();
  }

  changeLanguage(Language lang) {
    _language = lang;
    notifyListeners();
  }
}
