import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  Teal,
  BlueLight,
  Dark,
}

final appThemeData = {
  AppTheme.GreenLight: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.lightGreen,
    primaryColor: Colors.lightGreen
  ),
  AppTheme.Teal: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
  ),
  AppTheme.BlueLight: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.lightBlue,
    dividerColor: Colors.blue[300]
  ),
  AppTheme.Dark: ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,

  ),
};