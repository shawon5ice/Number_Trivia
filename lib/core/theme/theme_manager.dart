import 'package:ca_number_trivia/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import '../di/app_component.dart';
import '../session/session_manager.dart';
import '../shared_preferences/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  var session = locator<SessionManager>();
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
  );

  ThemeData? _themeData;
  ThemeData getTheme() => _themeData!;

  ThemeNotifier() {
    var themeMode = session.theme;
    if(themeMode == 'light-blue'){
      _themeData = appThemeData[AppTheme.BlueLight];
    }else if(themeMode == 'dark-blue'){
      _themeData = appThemeData[AppTheme.Dark];
    }else if(themeMode == 'dark-green'){
      _themeData = appThemeData[AppTheme.GreenDark];
    }else{
      _themeData = appThemeData[AppTheme.GreenLight];
    }

    notifyListeners();
    // StorageManager.readData('themeMode').then((value) {
    //   print('value read from storage: ' + value.toString());
    //   var themeMode = value ?? 'light';
    //   if (themeMode == 'light') {
    //     _themeData = lightTheme;
    //   } else {
    //     print('setting dark theme');
    //     _themeData = darkTheme;
    //   }
    //   notifyListeners();
    // });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    session.theme = 'dark';
    notifyListeners();
  }

  void setLightGreen() async {
    _themeData = appThemeData[AppTheme.GreenLight];
    session.theme = 'light-green';
    notifyListeners();
  }
  void setDarkGreen() async {
    _themeData = appThemeData[AppTheme.GreenDark];
    session.theme = 'dark-green';
    notifyListeners();
  }

  void setLightBlue() async {
    _themeData = appThemeData[AppTheme.BlueLight];
    session.theme = 'light-blue';
    notifyListeners();
  }
  void setDarkBlue() async {
    _themeData = appThemeData[AppTheme.Dark];
    session.theme = 'dark-blue';
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    session.theme = 'light';
    notifyListeners();
  }
}