import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/custom_password_field.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/screens/auth_screens/forgot_password_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/register_screen.dart';
import 'package:loxcorpserv/screens/main_screens/location.dart';
import 'package:loxcorpserv/services/string_sanitizer.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  void initState() {
    provButtonLoadingEnd(context, false);
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
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
              heightBoxSize(height: 80.0),
              loginButton(
                context,
                emailController,
                passwordController,
                provider,
              ),
              heightBoxSize(height: 20.0),
              const CustomButton(
                text: "Forgot your password?",
                isTextColor: true,
                customTextColor: primaryColor,
                pageRoute: ForgotPasswordScreen(),
                bgColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container loginButton(
  context,
  emailController,
  passwordController,
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
              if (emailController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter email to proceed",
                  isSuccess: false,
                );
                return;
              }
              if (!await StringSanitizer()
                  .emailFormatter(emailController.text)) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Wrong email format",
                  isSuccess: false,
                );
                return;
              }
              if (passwordController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter password to proceed",
                  isSuccess: false,
                );
                return;
              }

              provider.buttonStateLogin = true;
              provider.render();
              var response = await UserAuthService().userLoginService(
                context,
                emailController,
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
              /**clear the form input */
              emailController.clear();
              passwordController.clear();
              /**stop loading button */
              toastSnackBar(
                context: context,
                textMessage: response['message'].toString(),
                isSuccess: true,
              );

              Navigator.push(
                context,
                PageTransitionRoute(
                  child: const Location(),
                  duration: pageTransitionDuration,
                  direction: PageAnimateDirection.right,
                ),
              );
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.white70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Login",
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
            "Login",
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
