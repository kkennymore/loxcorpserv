import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpAutoFillInput extends StatelessWidget {
  const OtpAutoFillInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ButtonProvider>(context);
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: TextFieldPinAutoFill(
        decoration: InputDecoration(
          //========Border On Focus=======
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            borderRadius:
                BorderRadius.all(Radius.circular(formInputBorderRadius)),
          ),
          //======Set the input border color and radius=========
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            borderRadius:
                BorderRadius.all(Radius.circular(formInputBorderRadius)),
          ),

          //======This is the hint/placeholder and Label for the input field=========
          hintText: "OTP Code",
          labelText: "OTP Code",
          //====Set the Place holder color and size======
          labelStyle: TextStyle(
            color: primaryColor,
            fontSize: textInputFontSize,
            fontWeight: FontWeight.bold,
          ),
          //==========This is the eye icon to reveal the password===========
          suffixIcon: IconButton(
            icon: Icon(
              Icons.lock_outline,
              //======Shorthand if and else conditional statement to set the active and inactive button color
              color: prov.obscureText
                  ? primaryColor
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
        ), // basic InputDecoration
        onCodeSubmitted: (value) {
          print("###########: Code submitted");
        },
        currentCode: "",
        style: const TextStyle(
          color: primaryColor,
          fontStyle: FontStyle.normal,
        ), // prefill with a code
        onCodeChanged: (value) {
          print("###########: Code submitted ${value}");
        }, //code changed callback
        codeLength: 6,
        autoFocus: true,
      ),
    );
  }
}
