import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/string_sanitizer.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/register_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/reset_password.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  @override
  void initState() {
    provButtonLoadingEnd(context, false);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
                  controller: emailController,
                  label: "Email",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  keyboardType: TextInputType.emailAddress,
                  textColor: Colors.black,
                ),
              ),
              heightBoxSize(height: 5.0),
              loginToAccount(context),
              heightBoxSize(height: 40.0),
              forgotPasswordButton(
                context,
                emailController,
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

Container forgotPasswordButton(
  BuildContext context,
  TextEditingController? emailController,
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
              if (emailController!.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter email to proceed",
                  isSuccess: false,
                );
                return;
              }

              /**password */
              if (!await StringSanitizer()
                  .emailFormatter(emailController.text)) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Wrong email pattern",
                  isSuccess: false,
                );
                return;
              }

              var smsCode = await generateOTP();
              var email = emailController.text;

              provider.buttonStateLogin = true;
              provider.render();
              var response = await UserAuthService()
                  .forgotPasswordService(context, emailController, smsCode);

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
              emailController.clear();
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
                    child: ResetPassword(
                      email: email,
                      smsCode: smsCode,
                    ),
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
                  "reset password",
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
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 5.0, right: 0.0),
          child: const Text(
            "want to login now?",
            style: TextStyle(
              color: Colors.black45,
            ),
          ),
        ),
        const CustomButton(
          text: "Login",
          isTextColor: true,
          customTextColor: primaryColor,
          pageRoute: LoginScreen(),
          bgColor: Colors.transparent,
          width: 70.0,
        )
      ],
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
