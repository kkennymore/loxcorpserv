import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';

class Accordion extends StatelessWidget {
  final String? title;
  final String? description;
  final Color? textColor;
  final double fontsSize;

  const Accordion({
    super.key,
    this.title,
    this.description,
    this.textColor = Colors.black,
    this.fontsSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: ExpansionTile(
        iconColor: primaryColor,
        tilePadding: const EdgeInsets.all(0.0),
        title: Text(
          title!,
          style: TextStyle(
            color: textColor,
            fontSize: fontsSize,
            fontWeight: FontWeight.bold,
          ),
        ), //header title
        children: [
          Container(
            padding: const EdgeInsets.only(bottom:10.0, top:0.0),
            width: double.infinity,
            child: Text(
              description!,
              style: TextStyle(
                color: textColor!.withOpacity(0.6),
                fontSize: fontsSize-1,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
