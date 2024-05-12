import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataHandler {
  static late SharedPreferences _preferences;


  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String getString(String key, {String defaultValue = ""}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  static Future<void> saveBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  static Future<void> saveInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  static Future<void> saveDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  static Future<void> saveMapList(String key, List<Map<String, dynamic>> valueList) async {
    List<String> jsonList = valueList.map((map) => json.encode(map)).toList();
    await _preferences.setStringList(key, jsonList);
  }

  static List getMapList(String key) {
    List<String>? jsonList = _preferences.getStringList(key);
    if (jsonList != null) {
      return jsonList.map((jsonString) => json.decode(jsonString)).toList();
    } else {
      return [];
    }
  }


  static Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }
}


///Usage
// @override
// void initState() {
//   super.initState();
//   // Initialize SharedPreferences
//   MySharedPreferences.init();
//   // Retrieve saved string from SharedPreferences
//   _savedString = MySharedPreferences.getString('myStringKey', defaultValue: 'No data saved');
// }
