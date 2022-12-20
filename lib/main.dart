import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/splash.dart';
import 'package:loxcorpserv/home.dart';
import 'package:loxcorpserv/providers.dart';
import 'package:loxcorpserv/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(const Runner());
}

// whenever your initialization is completed, remove the splash screen:
// FlutterNativeSplash.remove();
class Runner extends StatelessWidget {
  const Runner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: myProviders,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          darkTheme: darkTheme(context),
          home: AnimatedSplashScreen(
            splash: const Splash(),
            nextScreen: const Home(),
            splashTransition: SplashTransition.fadeTransition,
            splashIconSize: 1000.0,
          ),
        );
      },
    );
  }
}
