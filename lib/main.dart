import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitme/pages/home.dart';
import "package:gitme/pages/login.dart";
import 'package:gitme/pages/profile/profile.dart';
import 'package:gitme/pages/setting/setting.dart';
import 'package:gitme/pages/trending/trending.dart';
import 'package:gitme/routes.dart';
import 'package:gitme/stores/account.dart';
import 'package:gitme/stores/setting.dart';
import 'package:provider/provider.dart';

import 'pages/about/about.dart';
import 'pages/setting/setting_language.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
          useCountryCode: true,
          fallbackFile: "en_US",
          basePath: "assets/i18n",
          forcedLocale: Locale("en", "US"),
          decodeStrategies: [JsonDecodeStrategy()]));

  await flutterI18nDelegate.load(Locale("en", "US"));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (BuildContext context) => AccountModel()),
      ChangeNotifierProvider(create: (BuildContext context) => SettingModel())
    ],
    child: Gitme(flutterI18nDelegate),
  ));
}

class Gitme extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  Gitme(this.flutterI18nDelegate);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var setting = Provider.of<SettingModel>(context);

    return MaterialApp(
      title: "Gitme",
      theme: setting.theme,
      routes: {
        GitmeRoutes.login: (context) => LoginPage(),
        GitmeRoutes.home: (context) => MainPage(),
        GitmeRoutes.profile: (context) => ProfilePage(),
        GitmeRoutes.trending: (context) => TrendingPage(),
        GitmeRoutes.setting: (context) => SettingPage(),
        GitmeRoutes.settingLanguage: (context) => SettingLanguagePage(),
        GitmeRoutes.about: (context) => AboutPage(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case GitmeRoutes.root:
            return MaterialPageRoute(builder: (context) => LoginPage());
          default:
            return MaterialPageRoute(builder: (context) => LoginPage());
        }
      },
      localizationsDelegates: [
        flutterI18nDelegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
