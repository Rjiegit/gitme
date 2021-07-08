import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

Color hexToColor(String code) {
  return Color(
      int.parse(code.substring(1, code.length - 1), radix: 16) + 0xFF000000);
}

Future<String?> searchLanguageColorHexCode(String? language) async {
  String githubColors =
      await rootBundle.loadString("assets/data/github-colors.json");
  var githubColorsMap = jsonDecode(githubColors);

  if (githubColorsMap[language] == null) {
    return null;
  }

  return githubColorsMap[language]["color"];
}

Future launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

enum NotifyType { info, warning, error }

void showNotify({required String message, NotifyType type = NotifyType.info}) {
  late Color _textColor;
  late Color _backgroundColor;

  switch (type) {
    case NotifyType.warning:
      _textColor = Colors.black38;
      _backgroundColor = Colors.amber;
      break;
    case NotifyType.error:
      _textColor = Colors.black38;
      _backgroundColor = Colors.deepOrange.shade300;
      break;
    default:
      break;
  }

  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    textColor: _textColor,
    backgroundColor: _backgroundColor,
  );
}

void showToast(
    {required BuildContext context,
    required String message,
    NotifyType type = NotifyType.info}) {
  late Color _textColor;
  late Color _backgroundColor;

  switch (type) {
    case NotifyType.warning:
      _textColor = Colors.black38;
      _backgroundColor = Colors.amber;
      break;
    case NotifyType.error:
      _textColor = Colors.black38;
      _backgroundColor = Colors.deepOrange.shade300;
      break;
    case NotifyType.info:
      _textColor = Colors.black38;
      _backgroundColor = Colors.white70;
      break;
    default:
      break;
  }

  FToast fToast;

  fToast = FToast();
  fToast.init(context);

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: _backgroundColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 12.0,
        ),
        Text(
          message,
          style: TextStyle(color: _textColor),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: Duration(seconds: 2),
  );
}
