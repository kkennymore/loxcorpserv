import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_password_field.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/register_screen.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class VerifyAccount extends StatefulWidget {
  final String? email;
  final String? smsCode;
  const VerifyAccount({super.key, this.email, this.smsCode});

  @override
  State<VerifyAccount> createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final smsCodeController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    provButtonLoadingEnd(context, false);
    super.initState();
  }

  @override
  void dispose() {
    smsCodeController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    var provider = Provider.of<ButtonProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBoxSize(height: 40.0),
              topHeader(context),
              heightBoxSize(height: 30.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: CustomeTextFormField(
                  controller: smsCodeController,
                  label: "______",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  keyboardType: TextInputType.number,
                  textColor: Colors.black,
                  isOTP: true,
                ),
              ),
              heightBoxSize(height: 20.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: CustomPasswordField(
                  controller: passwordController,
                  texthint: "Password",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  textColor: Colors.black,
                  suffixIcon: CommunityMaterialIcons.eye,
                ),
              ),
              heightBoxSize(height: 20.0),
              loginToAccount(context),
              heightBoxSize(height: 40.0),
              verifyAccountButton(
                context,
                widget.email.toString(),
                widget.smsCode.toString(),
                smsCodeController,
                passwordController,
                provider,
              ),
              heightBoxSize(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

Container verifyAccountButton(
  BuildContext context,
  String? emailData,
  String? smsCodeData,
  TextEditingController smsCodeController,
  TextEditingController passwordController,
  provider,
) {
  return Container(
    width: MediaQuery.of(context).size.width - 45,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
      border: Border.all(width: 1.5, color: primaryColor),
      color: primaryColor,
    ),
    child: provider.buttonStateLogin == true
        ? circularProgress(
            isLinear: false,
            textLabel: "loading...",
          )
        : MaterialButton(
            onPressed: () async {
              if (emailData == '') {
                toastSnackBar(
                  context: context,
                  textMessage: "Enter email to proceed",
                  isSuccess: false,
                );
                return;
              }
              if (smsCodeController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter OTP Code to proceed",
                  isSuccess: false,
                );
                return;
              }
              /**check if the otp is correct */
              if (smsCodeData != smsCodeController.text) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Incorrect OTP Code",
                  isSuccess: false,
                );
                return;
              }
              /**password */
              if (passwordController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter account password to proceed",
                  isSuccess: false,
                );
                return;
              }

              provider.buttonStateLogin = true;
              provider.render();
              var response = await UserAuthService().verifyAccountService(
                context,
                emailData,
                smsCodeController,
                passwordController,
              );

              provider.buttonStateLogin = false;
              provider.render();
              if (response['status'] == false) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: response['message'].toString(),
                  isSuccess: false,
                );
                return;
              }

              smsCodeController.clear();
              passwordController.clear();
              if (response['status'] == true) {
                /**stop loading button */
                toastSnackBar(
                  context: context,
                  textMessage: response['message'].toString(),
                  isSuccess: true,
                );
                Navigator.push(
                  context,
                  PageTransitionRoute(
                    child: LoginScreen(),
                    duration: pageTransitionDuration,
                    direction: PageAnimateDirection.right,
                  ),
                );
              }
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
  );
}

Container loginToAccount(context) {
  return Container(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
    child: const Text(
      "An email was sent to your containing the OTP verification code, Please check your inbox or spam folder and use the code to activate your account",
      style: TextStyle(
        color: Colors.black54,
        fontSize: 12.0,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Container topHeader(context) {
  return Container(
    padding: const EdgeInsets.only(),
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Container(),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(),
          child: const Text(
            "Verify Email",
            style: TextStyle(
              color: primaryTextColor,
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        MaterialButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransitionRoute(
                child: const RegisterScreen(),
                duration: pageTransitionDuration,
                direction: PageAnimateDirection.left,
              ),
            );
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
