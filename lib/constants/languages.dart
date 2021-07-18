import 'package:flutter/material.dart';

enum Language { traditionalChinese, english }

Map langLocaleMap = {
  Language.english: Locale("en", "US"),
  Language.traditionalChinese: Locale("zh", "TW"),
};

Map localeLangStrMap = {
  "en_US": "English",
  "zh_TW": "繁體中文",
};
