
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loxcorpserv/public/colors.dart';

const appBarTheme = AppBarTheme(
  centerTitle: false,
  elevation: 0,
  backgroundColor: Colors.white,
);

final tabBarTheme = TabBarTheme(
  indicatorSize: TabBarIndicatorSize.label,
  unselectedLabelColor: Colors.black54,
  indicator: BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: primaryColor,
  ),
);

final dividerTheme =
    const DividerThemeData().copyWith(thickness: 1.0, indent: 75.0);

ThemeData lightTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: primaryWhiteColor,
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme,
      dividerTheme: dividerTheme.copyWith(color: primaryIconLight),
      iconTheme: const IconThemeData(color: primaryIconLight),
      textTheme: GoogleFonts.tangerineTextTheme(Theme.of(context).textTheme)
          .apply(displayColor: primaryBlackColor, fontFamily: 'Mulish'),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
    primaryColor: Colors.transparent,
    scaffoldBackgroundColor: primaryBlackColor,
    tabBarTheme: tabBarTheme.copyWith(unselectedLabelColor: Colors.white70),
    appBarTheme: appBarTheme.copyWith(backgroundColor: darkPrimaryColor),
    dividerTheme: dividerTheme.copyWith(color: primaryWhiteColor),
    iconTheme: const IconThemeData(color: primaryBlackColor),
    textTheme: GoogleFonts.tangerineTextTheme(Theme.of(context).textTheme)
        .apply(displayColor: primaryWhiteColor, fontFamily: 'bc_blcak'),
    visualDensity: VisualDensity.adaptivePlatformDensity);

bool isLightTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light;
}
