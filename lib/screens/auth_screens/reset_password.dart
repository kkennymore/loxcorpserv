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

class ResetPassword extends StatefulWidget {
  final String? email;
  final String? smsCode;
  const ResetPassword({super.key, this.email, this.smsCode});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final smsCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  @override
  void initState() {
    provButtonLoadingEnd(context, false);
    super.initState();
  }

  @override
  void dispose() {
    smsCodeController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
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
                child: CustomPasswordField(
                  controller: passwordController,
                  texthint: "New Password",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  textColor: Colors.black,
                  suffixIcon: CommunityMaterialIcons.eye,
                ),
              ),
              heightBoxSize(height: 20.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: CustomPasswordField(
                  controller: passwordConfirmController,
                  texthint: "Confirm Password",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  textColor: Colors.black,
                  suffixIcon: CommunityMaterialIcons.eye,
                ),
              ),
              heightBoxSize(height: 20.0),
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
              heightBoxSize(height: 10.0),
              loginToAccount(context),
              heightBoxSize(height: 40.0),
              resetPasswordButton(
                context,
                widget.email.toString(),
                widget.smsCode.toString(),
                smsCodeController,
                passwordController,
                passwordConfirmController,
                provider,
              ),
              heightBoxSize(height: 50.0),
              Container(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(),
                      child: const Text(
                        "Use the OTP code below to actiavate your account, this is for development purpose only as the email service is not fully configured,",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(),
                      child: Text(
                        widget.smsCode.toString(),
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              heightBoxSize(height: 100.0),
            ],
          ),
        ),
      ),
    );
  }
}

Container resetPasswordButton(
  BuildContext context,
  String? emailData,
  String? smsCodeData,
  TextEditingController smsCodeController,
  TextEditingController passwordController,
  TextEditingController passwordConfirmController,
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
             
              
              /**password */
              if (passwordController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter new password to proceed",
                  isSuccess: false,
                );
                return;
              }
              /**password */
              if (passwordConfirmController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "confirm password to proceed",
                  isSuccess: false,
                );
                return;
              }
              if (passwordConfirmController.text != passwordController.text) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "password does not match",
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

              provider.buttonStateLogin = true;
              provider.render();
              var response = await UserAuthService().resetPasswordService(
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
                  "Save Changes",
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
            "Reset Password",
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
