import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gitme/pages/home.dart';
import "package:gitme/pages/login.dart";
import 'package:gitme/pages/profile/profile.dart';
import 'package:gitme/pages/setting/setting.dart';
import 'package:gitme/pages/trending/trending.dart';
import 'package:gitme/routes.dart';
import 'package:gitme/stores/account.dart';
import 'package:provider/provider.dart';

import 'pages/about/about.dart';
import 'pages/setting/setting_language.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => AccountModel(),
      ),
    ],
    child: Gitme(),
  ));
}

class Gitme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitme",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueGrey,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
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
    );
  }
}
