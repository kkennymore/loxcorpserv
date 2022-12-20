import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/theme.dart';

class ImageFullView extends StatefulWidget {
  String? parth;
  ImageFullView({
    this.parth,
    Key? key,
  }) : super(key: key);

  @override
  State<ImageFullView> createState() => _ImageFullViewState();
}

class _ImageFullViewState extends State<ImageFullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        toolbarHeight: 0.0,
      ),
      extendBody: true,
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(0.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: InteractiveViewer(
            child: Image.file(
              File(widget.parth.toString()),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
