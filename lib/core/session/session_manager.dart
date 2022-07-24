import 'dart:convert';

import '../data/pref_manager.dart';
import '../utils/constant.dart';


class SessionManager {

  final PrefManager _prefManager;

  SessionManager(this._prefManager);

  String? get theme => _prefManager.getStringValue(currentTheme);

  set theme(String? value) => _prefManager.saveString(currentTheme, value ?? "light");

  double? get fontSize => _prefManager.getDoubleValue(currentFontSize);

  set fontSize(double? value) => _prefManager.saveDouble(currentFontSize, value ?? 24);

}