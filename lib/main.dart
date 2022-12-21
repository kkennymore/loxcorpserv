import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/splash.dart';
import 'package:loxcorpserv/home.dart';
import 'package:loxcorpserv/providers.dart';
import 'package:loxcorpserv/screens/main_screens/location.dart';
import 'package:loxcorpserv/services/local_storage.dart';
import 'package:loxcorpserv/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 300));
  
  /*check if the user has logged in and redirect to appropriate screen */
  if (await LocalStorage().get("email") == "" ||
      await LocalStorage().get("email") == null) {
    runApp(const Runner(isIn: 0));
  } else {
    runApp(const Runner(isIn: 1));
  }
}

// whenever your initialization is completed, remove the splash screen:
// FlutterNativeSplash.remove();
class Runner extends StatelessWidget {
  final int? isIn;
  const Runner({Key? key, this.isIn}) : super(key: key);

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
            nextScreen: isIn == 0 ? const Home() : const Location(),
            splashTransition: SplashTransition.fadeTransition,
            splashIconSize: 1000.0,
          ),
        );
      },
    );
  }
}
