import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class SuffixIconTextInput extends StatelessWidget {
  TextEditingController? controller;
  TextInputType? keyboardType;
  String? label;
  IconData? suffixIcon;
  Color bgColor;
  Color textColor;
  Color iconBg;
  bool? isShowIcon;
  double? iconSizes = 14.0;
  SuffixIconTextInput({
    this.controller,
    this.keyboardType,
    this.label,
    this.suffixIcon,
    this.bgColor = primaryColor,
    this.textColor = primaryTextColor,
    this.iconBg = primaryColor,
    this.isShowIcon = false,
    this.iconSizes,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ButtonProvider>(context);
    return Container(
      key: key,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textColor,
          fontStyle: FontStyle.normal,
        ),
        autofocus: false,
        decoration: InputDecoration(
          //========Border On Focus=======
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor.withOpacity(0.2),
              width: 0.0,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(formInputBorderRadius)),
          ),
          //======Set the input border color and radius=========
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor.withOpacity(0.0),
              width: 0.0,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(formInputBorderRadius)),
          ),
          suffixIcon: Icon(
            suffixIcon,
            //======Shorthand if and else conditional statement to set the active and inactive button color
            color: iconBg,
            size: iconSizes,
          ),
          //prefixIcon: prefixIcon,
          hintText: label,
          //labelText: label,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          hintStyle: TextStyle(
            color: textColor.withOpacity(0.4),
            fontSize: textInputFontSize,
          ),
          labelStyle: TextStyle(
            color: textColor.withOpacity(0.1),
            fontSize: textInputFontSize,
            fontWeight: FontWeight.bold,
          ),
          filled: true,
          fillColor: bgColor,
        ),
        cursorHeight: 30.0,
        cursorWidth: 2.0,
        cursorColor: textColor,
      ),
    );
  }
}
