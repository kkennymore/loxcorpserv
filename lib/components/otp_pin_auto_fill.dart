import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpPinAutoFill extends StatelessWidget {
  String? otpCode;
  final Color? bgColor;
  final String? label;
  final Color? textColor;
  final Color? borderColor;

  OtpPinAutoFill({
    Key? key,
    this.otpCode,
    this.bgColor = Colors.white,
    this.borderColor = Colors.black26,
    this.label,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ButtonProvider>(context);
    return Container(
      height: 47.0,
      decoration: BoxDecoration(
        color: bgColor!,
        border: Border.all(
          color: borderColor!,
        ),
        borderRadius: BorderRadius.all(Radius.circular(formInputBorderRadius)),
      ),
      padding:
          const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      child: PinFieldAutoFill(
        decoration: UnderlineDecoration(
          colorBuilder: FixedColorBuilder(borderColor!),
          textStyle: TextStyle(
            color: textColor,
            fontSize: textInputFontSize + 10,
            fontWeight: FontWeight.bold,
          ),
        ), // UnderlineDecoration, BoxLooseDecoration or BoxTightDecoration see https://github.com/TinoGuo/pin_input_text_field for more info,
        //currentCode: "", // prefill with a code
        onCodeSubmitted: (value) {
          provider.otp = value;
          provider.render();
        }, //code submitted callback
        onCodeChanged: (value) {
          if (value.toString().length >= 7) {
            provider.otp = value.toString();
            provider.render();
          }
        },
        autoFocus: true, //code changed callback
        //codeLength: //code length, default 6
      ),
    );
  }
}
