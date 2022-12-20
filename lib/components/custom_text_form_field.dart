import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class CustomeTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? label;
  final int? maxLines;
  final double? borderRadius;
  final bool? isOTP;

  Color bgColor;
  Color textColor;
  CustomeTextFormField({
    this.controller,
    this.keyboardType,
    this.label,
    this.bgColor = primaryColor,
    this.textColor = primaryColor,
    this.maxLines = 1,
    this.borderRadius = 10.0,
    this.isOTP = false,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ButtonProvider>(context);
    return Container(
      key: key,
      child: TextField(
        controller: controller,
        maxLength: isOTP! ? 6 : null,
        keyboardType: keyboardType,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          letterSpacing: isOTP! ? 34 : null ,
          fontSize: 20.0
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
                BorderRadius.all(Radius.circular(borderRadius!)),
          ),
          //======Set the input border color and radius=========
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: textColor.withOpacity(0.0),
              width: 0.0,
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(borderRadius!)),
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
        onChanged: (value) {
          prov.textOnchange = value.toString();
          prov.render();
        },
        maxLines: maxLines,
      ),
    );
  }
}
