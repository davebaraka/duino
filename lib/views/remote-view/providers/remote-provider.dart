import 'package:flutter/material.dart';

class RemoteProvider with ChangeNotifier {
  int groupValue = 0;

  void updateGroupValue(int value) {
    groupValue = value;
    notifyListeners();
  }
}