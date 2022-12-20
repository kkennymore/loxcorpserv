import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget? childWidget;
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddingLeft;
  final double? paddingRight;
  final double? innerPaddingTop;
  final double? innerPaddingBottom;
  final double? innerPaddingLeft;
  final double? innerPaddingRight;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? borderShadow;
  const CustomCard({
    super.key,
    required this.childWidget,
    this.paddingTop = 0.0,
    this.paddingBottom = 0.0,
    this.paddingLeft = 0.0,
    this.paddingRight = 0.0,
    this.innerPaddingTop = 0.0,
    this.innerPaddingBottom = 0.0,
    this.innerPaddingLeft = 0.0,
    this.innerPaddingRight = 0.0,
    this.backgroundColor = primaryColor,
    this.borderRadius = 0.0,
    this.borderShadow = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: paddingTop!,
        bottom: paddingBottom!,
        left: paddingLeft!,
        right: paddingRight!,
      ),
      child: Card(
        elevation: borderShadow,
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
            top: innerPaddingTop!,
            bottom: innerPaddingBottom!,
            left: innerPaddingLeft!,
            right: innerPaddingRight!,
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
