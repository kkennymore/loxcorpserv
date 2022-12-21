import 'package:flutter/material.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final double width;
  final double height;
  final double radius;
  final Widget? pageRoute;
  final PageAnimateDirection direction;
  final Color bgColor;
  final Color bdColor;
  final bool isTextColor;
  final bool isFontWeight;
  final bool isNavReplace;
  final Color customTextColor;
  final double fontSize;
  final bool isPrefixIcon;
  final bool isSurfixIcon;
  final IconData? surfixIcon;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final Color surfixIconColor;
  final double iconSize;
  final List? data;
  const CustomButton({
    Key? key,
    required this.text,
    this.width = 259.0,
    this.height = 46.0,
    this.radius = 27,
    this.pageRoute,
    this.direction = PageAnimateDirection.left,
    this.bgColor = primaryColor,
    this.bdColor = Colors.transparent,
    this.isTextColor = false,
    this.isFontWeight = false,
    this.isNavReplace = false,
    this.customTextColor = primaryTextColor,
    this.fontSize = 14.0,
    this.isPrefixIcon = false,
    this.isSurfixIcon = false,
    this.prefixIcon,
    this.surfixIcon,
    this.prefixIconColor = primaryIconLight,
    this.surfixIconColor = primaryIconLight,
    this.iconSize = 24.0,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height, //46.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        border: Border.all(width: 1.5, color: bdColor),
        color: bgColor,
      ),
      child: MaterialButton(
        onPressed: () async {
          /**check if the data is empty */
          if (data == null) {
            if (isNavReplace) {
              Navigator.pushAndRemoveUntil(
                context,
                PageTransitionRoute(
                  child: pageRoute!,
                  duration: pageTransitionDuration,
                  direction: direction,
                ),
                (route) => false,
              );
            } else {
              Navigator.push(
                context,
                PageTransitionRoute(
                  child: pageRoute!,
                  duration: pageTransitionDuration,
                  direction: direction,
                ),
              );
            }
          }
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isPrefixIcon
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Icon(
                      prefixIcon,
                      color: prefixIconColor,
                      size: iconSize,
                    ),
                  )
                : Container(),
            Text(
              text!,
              style: TextStyle(
                color: customTextColor,
                fontWeight: isFontWeight ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize,
              ),
            ),
            isSurfixIcon
                ? Icon(
                    surfixIcon,
                    color: surfixIconColor,
                    size: iconSize,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
