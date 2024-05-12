import 'package:flutter/foundation.dart';

class AppPrinter {
  void printWithTag(String tag, String message) {
    DateTime now = DateTime.now();
    String time = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}:'
        '${now.second.toString().padLeft(2, '0')}';
    if (kDebugMode) {
      print('[$time][$tag] => $message');
    }
  }
}