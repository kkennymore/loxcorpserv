import 'package:flutter/material.dart';

class ButtonProvider extends ChangeNotifier {

  bool obscureText = true;
  bool buttonStateLogin = false;
  bool buttonStateRegister = false;
  bool showClassFilterPane = false;
  bool isChecked = false;
  String otp = "";
  
  String textOnchange = "";


  void render() {
    notifyListeners();
  }
}
