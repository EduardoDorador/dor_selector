import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  bool _info = false;

  set info(bool val) {
    _info = val;
    notifyListeners();
  }

  bool get info {
    return _info;
  }
}
