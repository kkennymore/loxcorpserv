import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/splash_bg.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        ),
        Image.asset(
          "assets/images/user_splash_icon.png",
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.height/2,
        ),
      ],
    );
  }
}
