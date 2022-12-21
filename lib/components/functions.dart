import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/main_screens/location.dart';
import 'package:loxcorpserv/services/local_storage.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui' as ui;

//===============================
SizedBox heightBoxSize({height = 20.0}) {
  return SizedBox(height: height);
}

SizedBox widthBoxSize({width = 20.0}) {
  return SizedBox(width: width);
}

Builder horizontalDivider(
    {lineColor = primaryLightGrey, width = 100.0, lineHight = 1.0}) {
  return Builder(builder: (BuildContext context) {
    return Container(
      width: width,
      height: lineHight,
      color: lineColor,
    );
  });
}

void isLoggedIn(context, {bool? isIn = false}) async {
  /*check if the user has logged in and redirect to appropriate screen */
  if (isIn == true && await LocalStorage().get('email') != null) {
    Navigator.pop(context);
  } else {
    if (await LocalStorage().get('email') == null) {
      Navigator.pop(context);
    }
  }
}

Builder verticalDivider({
  lightColor = primaryLightGrey,
  height = 5.0,
}) {
  return Builder(builder: (BuildContext context) {
    return Container(
      width: 1.0,
      height: height,
      color: lightColor,
    );
  });
}

Builder textLabel({
  required String? text,
  bool? fontWeight,
  bool? textMargin,
  Color? bgColor,
  bool? isCenter,
  bool? isNotHeader,
  bool? isColorRed,
  double borderRadius = 0.0,
  Color? color = Colors.black45,
  double paddingLeft = 10.0,
  double paddingRight = 10.0,
  double paddingBottom = 10.0,
  double paddingTop = 10.0,
  double fontsSize = 3,
}) {
  return Builder(
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            left: paddingLeft,
            right: paddingRight,
            bottom: paddingBottom,
            top: paddingTop),
        margin: textMargin == true
            ? const EdgeInsets.all(10.0)
            : const EdgeInsets.all(0.0),
        child: SelectableText(
          text.toString(),
          style: TextStyle(
            color: primaryColor,
            fontSize:
                isNotHeader == true ? bodyTextSize - fontsSize : titleTextLabel,
            fontWeight:
                fontWeight == true ? FontWeight.bold : FontWeight.normal,
          ),
          textAlign: isCenter == true ? TextAlign.center : TextAlign.start,
        ),
      );
    },
  );
}

Future generateOTP() async {
  //return DateTime.now().microsecond.toString()+DateTime.now().microsecond.toString();
  var rng = Random(DateTime.now().microsecond);
  return rng.nextInt(1000000000).toString().substring(0, 6);
}

Future redirectIfTrue({required BuildContext context, bool? isAddTo}) async {
  if (isAddTo == true) {
    Navigator.push(
      context,
      PageTransitionRoute(
        child: const LoginScreen(),
        duration: pageTransitionDuration,
        direction: PageAnimateDirection.right,
      ),
    );
  }
}

Future<void> saveAndShare(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/clans_connect.png');
  image.writeAsBytesSync(bytes);
  await Share.shareFiles([image.path]);
}

//=====RERENDER WIDGET AS AN IMAGE FILE============//
Future saveQRCodeAsImage(key) async {
  if (key == null) return null;
  RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final pngFile = byteData!.buffer.asUint8List();
  saveAndShare(pngFile);
}

//=======Page auto scroll to the bottom=========
pageAutoScroll(controller) {
  Timer(
    const Duration(milliseconds: 300),
    () => controller.jumpTo(controller.position.maxScrollExtent),
  );
}

const shadowTheBox = [
  BoxShadow(
    color: Color.fromARGB(050, 255, 255, 255),
    blurRadius: 0.0, // has the effect of softening the shadow
    spreadRadius: 0.0, // has the effect of extending the shadow
    offset: Offset(
      0.0, // horizontal, move right 10
      0.0, // vertical, move down 10
    ),
  ),
];

Builder circularProgress({
  String? textLabel,
  bool? isLinear,
  bool? isBgTransparent = false,
  bool? isMarginBottom = false,
  double width = 259.0,
  double height = 46.0,
}) {
  return Builder(
    builder: (BuildContext context) {
      return Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        margin: isMarginBottom == true
            ? const EdgeInsets.only(bottom: 20.0)
            : const EdgeInsets.only(bottom: 0.0),
        child: MaterialButton(
          shape: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(btnBorderRadius)),
          ),
          minWidth: MediaQuery.of(context).size.width - 150,
          padding: const EdgeInsets.only(top: 13.0, bottom: 13.0),
          elevation: 0,
          color: primaryColor,
          onPressed: () {},
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  textLabel.toString(),
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: textInputFontSize,
                  ),
                ),
              ),
              widthBoxSize(),
              isLinear == true
                  ? Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 40.0,
                      height: 5.0,
                      child: const LinearProgressIndicator(
                        backgroundColor: Colors.white54,
                        minHeight: 4.0,
                        color: Colors.white54,
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 15.0,
                      height: 15.0,
                      child: const CircularProgressIndicator(
                        backgroundColor: Colors.white54,
                        strokeWidth: 2.0,
                        color: Colors.white54,
                      ),
                    ),
            ],
          ),
        ),
      );
    },
  );
}

//=======select image from directory==========//
Future chooseDevicePhotos() async {
  PickedFile? file =
      await ImagePicker.platform.pickImage(source: ImageSource.gallery);
  if (file != null || file != "") {
    return file!.path;
  } else {
    return "";
  }
}

Container richTextCustom(
  context, {
  String? textOne = '',
  String? textTwo = '',
  Color? textOneColor,
  Color? textTwoColor,
  double fontsSize = 14.0,
  double horizontalPadding = 0.0,
  bool fontWeightOne = true,
  bool fontWeightTwo = true,
  Color? textColor = primaryTextColor,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
    child: RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        style: TextStyle(
          color: textColor,
          height: 1.7,
        ),
        children: <TextSpan>[
          TextSpan(
            text: textOne,
            style: TextStyle(
              color: textOneColor,
              fontSize: fontsSize,
              fontWeight:
                  fontWeightOne == true ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          TextSpan(
            text: textTwo,
            style: TextStyle(
              color: textTwoColor,
              fontSize: fontsSize,
              fontWeight:
                  fontWeightTwo == true ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    ),
  );
}

toastSnackBar({
  required BuildContext context,
  required String textMessage,
  bool isSuccess = false,
  bool isVibrate = false,
}) {
  var snackBar = SnackBar(
    content: Builder(builder: (context) {
      if (isSuccess) {
        /**return the success message */
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 100.0,
          child: Text(
            textMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.green,
            ),
          ),
        );
      } else {
        /** return the error message*/
        return Container(
          padding: const EdgeInsets.all(10.0),
          height: 100.0,
          child: Text(
            textMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red.withOpacity(1),
            ),
          ),
        );
      }
    }),
    padding: const EdgeInsets.all(20.0),
    dismissDirection: DismissDirection.startToEnd,
    duration: const Duration(seconds: 2),
    backgroundColor: Colors.white,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

notInternet() {
  return {
    'status': false,
    'message': 'No internet connection',
  };
}

void provButtonLoadingEnd(context, bool state) {
  var provBtn = Provider.of<ButtonProvider>(context, listen: false);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    provBtn.obscureText = !state;
    provBtn.buttonStateLogin = state;
    provBtn.buttonStateRegister = state;
    provBtn.showClassFilterPane = state;
    /**render the page */
    provBtn.render();
  });
}
