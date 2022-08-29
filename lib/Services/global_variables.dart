import 'package:flutter/material.dart';

class GlobalVariables with ChangeNotifier {
  String cityGlobal = '';
  String cityCreatePost = '';

  transform(String value) {
    cityGlobal = value;
    notifyListeners();
  }

  transformCityCreatePost(String value) {
    cityCreatePost = value;
  }
}
