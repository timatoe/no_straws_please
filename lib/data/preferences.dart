import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences extends Model {

  Future<void> _loading;

  void load() {
    _loading = _loadFromSharedPrefs();
  }

  Future<void> _loadFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }
}