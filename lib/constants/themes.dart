import "package:flutter/material.dart";

enum AppLightTheme {
  Blue,
  BlueGrey,
  Brown,
}

final appLightThemeData = {
  AppLightTheme.Blue: ThemeData(
    primarySwatch: Colors.blue,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
  AppLightTheme.BlueGrey: ThemeData(
    primarySwatch: Colors.blueGrey,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueGrey,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
  AppLightTheme.Brown: ThemeData(
    primarySwatch: Colors.brown,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.brown,
      textTheme: ButtonTextTheme.primary,
    ),
  ),
};
