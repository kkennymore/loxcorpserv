import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/register_screen.dart';

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
              CustomButton(
                text: "Reset Password",
                isTextColor: true,
                customTextColor: Colors.white,
                pageRoute: const RegisterScreen(),
                width: MediaQuery.of(context).size.width - 45,
              ),
              heightBoxSize(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
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
