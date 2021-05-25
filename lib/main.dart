import 'package:flutter/material.dart';
import 'package:gitme/pages/home.dart';
import "package:gitme/pages/login.dart";
import 'package:gitme/routes.dart';

void main() {
  runApp(Gitme());
}

class Gitme extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gitme",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        GitmeRoutes.login: (context) => LoginPage(),
        GitmeRoutes.home: (context) => MainPage()
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
