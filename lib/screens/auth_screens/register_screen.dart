import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/custom_password_field.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/home.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/screens/auth_screens/forgot_password_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/auth_screens/verify_account.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    provButtonLoadingEnd(context, false);
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
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
                  controller: nameController,
                  label: "Name",
                  bgColor: primaryLightGrey.withOpacity(0.4),
                  keyboardType: TextInputType.text,
                  textColor: Colors.black,
                ),
              ),
              heightBoxSize(height: 20.0),
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
              heightBoxSize(height: 20.0),
              newsLetterSection(context, provider),
              heightBoxSize(height: 40.0),
              registerButton(
                context,
                nameController,
                emailController,
                passwordController,
                provider.isChecked,
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

Container registerButton(
  context,
  nameController,
  emailController,
  passwordController,
  agree,
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
              
              if (nameController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter name to proceed",
                  isSuccess: false,
                );
                return;
              }
              if (emailController.text.isEmpty) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Enter email to proceed",
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
              if (agree == false) {
                /**login successfully */
                toastSnackBar(
                  context: context,
                  textMessage: "Agree to proceed",
                  isSuccess: false,
                );
                return;
              }
              var smsCode = await generateOTP();
              var email = emailController.text;

              provider.buttonStateLogin = true;
              provider.render();
              var response = await UserAuthService().userRegisterationService(
                context,
                nameController,
                emailController,
                passwordController,
                agree,
                smsCode,
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
              nameController.clear();
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
                  child: VerifyAccount(email: email, smsCode: smsCode),
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
                  "Sign up",
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

Container newsLetterSection(context, prov) {
  return Container(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: prov.isChecked,
          onChanged: (val) {
            prov.isChecked = val!;
            prov.render();
          },
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              return primaryColor;
            },
          ),
        ),
        Expanded(
          child: RichText(
            overflow: TextOverflow.clip,
            textAlign: TextAlign.end,
            softWrap: true,
            textDirection: TextDirection.rtl,
            text: const TextSpan(
              style: TextStyle(
                color: primaryLightGrey,
                height: 1.8,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      "I would like to receive your newsletter and other promotional information.",
                  style: TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
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
          onPressed: () {
            Navigator.push(
              context,
              PageTransitionRoute(
                child: const Home(),
                duration: pageTransitionDuration,
                direction: PageAnimateDirection.right,
              ),
            );
          },
          icon: const Icon(
            CommunityMaterialIcons.close,
            color: Colors.black26,
            size: 16.0,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(),
          child: const Text(
            "Sign Up",
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
                child: const LoginScreen(),
                duration: pageTransitionDuration,
                direction: PageAnimateDirection.left,
              ),
            );
          },
          child: const Text(
            "Login",
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    ),
  );
}
