import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitme/constants/themes.dart';

class SettingModel extends ChangeNotifier {
  ThemeData _themeData = appLightThemeData[AppLightTheme.BlueGrey]!;

  ThemeData get theme => _themeData;

  changeTheme(themeData) {
    _themeData = appLightThemeData[themeData]!;
    notifyListeners();
  }
}
