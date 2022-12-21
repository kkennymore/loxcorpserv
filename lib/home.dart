import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/screens/auth_screens/register_screen.dart';
import 'package:loxcorpserv/screens/main_screens/location.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.only(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/splash_bg.png',
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      'assets/images/user_splash_icon.png',
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  heightBoxSize(height: 40.0),
                   const CustomButton(
                    text: "Get Started",
                    isTextColor: true,
                    customTextColor: Colors.white,
                    pageRoute: RegisterScreen(),
                  ),
                  heightBoxSize(height: 20.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
