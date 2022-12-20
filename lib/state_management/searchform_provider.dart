import 'package:flutter/material.dart';

class SearchFormProvider extends ChangeNotifier {
  String textData = "";
  void render() {
    notifyListeners();
  }
}
