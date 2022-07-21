import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier{
  ThemeMode _themeData = ThemeMode.light;

  get themeMode => _themeData;

  toggleTheme(bool isDark){
    _themeData = isDark? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}