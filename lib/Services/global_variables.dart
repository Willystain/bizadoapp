import 'package:flutter/material.dart';

class GlobalVariables with ChangeNotifier {
  String cityGlobal = '';

  transform(String value) {
    cityGlobal = value;
    notifyListeners();
  }
}
