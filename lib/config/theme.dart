import 'package:app_chat/config/const.dart';
import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: kBackgroundColorLight,
    colorScheme: ColorScheme.light(),
    primaryColorLight: Color(0xFFFEF9EB),
  );
}
