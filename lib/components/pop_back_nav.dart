import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';

AppBar popBackNav(
  context, {
  bool showTitle = false,
  String title = '',
  bool showImage = false,
  String imagePath = '',
  double imageRadius = 20.0,
  double imagePaddingLeft = 0.0,
  double imagePaddingRight = 0.0,
  double imagePaddingTop = 0.0,
  double imagePaddingBottom = 0.0,
  String setBackText = 'Back',
  bool showBottom = false,
  PreferredSizeWidget? bottomContent,
  Color bgColor = Colors.transparent,
}) {
  return AppBar(
    leadingWidth: 100.0,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Container(
        padding: const EdgeInsets.only(left: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              CommunityMaterialIcons.chevron_left,
              color: primaryColor,
            ),
            Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                setBackText,
                style: const TextStyle(
                  color: primaryColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    ),
    toolbarHeight: 40.0,
    backgroundColor: bgColor,
    title: showTitle == true
        ? Container(
            padding: const EdgeInsets.all(0.0),
            child: Text(title),
          )
        : Container(),
    actions: [
      showImage == true
          ? Container(
              padding: EdgeInsets.only(
                  right: imagePaddingRight,
                  left: imagePaddingLeft,
                  top: imagePaddingTop,
                  bottom: imagePaddingBottom),
              child: CircleAvatar(
                radius: imageRadius,
                backgroundImage: AssetImage(imagePath),
              ),
            )
          : Container(),
    ],
    bottom: showBottom == true
        ?  bottomContent
        : PreferredSize(
            child: Container(),
            preferredSize: Size.zero,
          ),
  );
}
