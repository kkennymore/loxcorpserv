import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class CustomPasswordField extends StatelessWidget {
  TextEditingController? controller;
  String? texthint;
  final IconData? suffixIcon;
  Color bgColor;
  Color textColor;
  CustomPasswordField({
    this.controller,
    this.texthint,
    this.suffixIcon,
    this.bgColor = primaryColor,
    this.textColor = primaryColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ButtonProvider>(context);
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: TextField(
        controller: controller,
        obscureText: prov.obscureText,
        decoration: InputDecoration(
          //========Border On Focus=======
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: textColor.withOpacity(0.2), width: 0.0),
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

          //======This is the hint/placeholder and Label for the input field=========
          hintText: texthint,
          //====Set the Place holder color and size======
          labelStyle: TextStyle(
            color: textColor,
            fontSize: textInputFontSize,
            fontWeight: FontWeight.bold,
          ),
          //==========This is the eye icon to reveal the password===========
          suffixIcon: IconButton(
            icon: Icon(
              suffixIcon,
              //======Shorthand if and else conditional statement to set the active and inactive button color
              color: prov.obscureText
                  ? textColor.withOpacity(0.2)
                  : primaryColor.withOpacity(0.80),
              size: iconSize,
            ),
            //==========Onclick ============
            onPressed: () {
              prov.obscureText = !prov.obscureText;
              prov.render();
            },
          ),
          //=============Add padding to the input textfield=========
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: textInputFontSize,
          ),
          filled: true,
          fillColor: bgColor,
        ),
        style: TextStyle(
          color: textColor,
          fontStyle: FontStyle.normal,
        ),
        cursorHeight: 30.0,
        cursorWidth: 2.0,
        cursorColor: textColor,
      ),
    );
  }
}
