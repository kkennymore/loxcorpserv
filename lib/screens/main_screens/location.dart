import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/main_screens/select_ride.dart';
import 'package:loxcorpserv/services/local_storage.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final currentLocationController = TextEditingController();
  final bagsController = TextEditingController();
  late String username = "username";

  @override
  void initState() {
    userData();
    isLoggedIn(context);

    super.initState();
  }

  void userData() async {
    print("##########: ${await LocalStorage().get('email').toString()}");
  }

  @override
  void dispose() {
    currentLocationController.dispose();
    bagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              heightBoxSize(height: 60.0),
              locationInputs(
                context,
                currentLocationController,
                bagsController,
              ),
              heightBoxSize(height: 60.0),
              welcomeBack(context, username),
              heightBoxSize(height: 250.0),
              
              heightBoxSize(height: 125.0),
              const CustomButton(
                text: "Done",
                isTextColor: true,
                customTextColor: Colors.white,
                pageRoute: SelectRide(),
              ),
              heightBoxSize(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

Container welcomeBack(context, username) {
  return Container(
    padding: const EdgeInsets.only(left: 25.0,right: 25.0),
    child: Text("google map is to be displayed here, i didn't implement it because i don't have the google APP API key"),
  );
}

Row locationInputs(context, currentLocationController, bagsController) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.only(left: 20.0, right: 5.0),
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: const Icon(
                CommunityMaterialIcons.map_marker_circle,
                size: 14.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 7.0, right: 0.0),
              child: horizontalDivider(
                lineColor: Colors.black.withOpacity(0.08),
                lineHight: 70.0,
                width: 1.0,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: const Icon(
                CommunityMaterialIcons.circle_box,
                size: 14.0,
              ),
            ),
          ],
        ),
      ),
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 40.0,
            padding: const EdgeInsets.only(left: 0.0, right: 5.0),
            child: CustomeTextFormField(
              controller: currentLocationController,
              label: "Current location",
              bgColor: primaryLightGrey.withOpacity(0.4),
              keyboardType: TextInputType.text,
              textColor: primaryColor,
              borderRadius: 5.0,
            ),
          ),
          heightBoxSize(height: 15.0),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: 40.0,
            padding: const EdgeInsets.only(left: 0.0, right: 5.0),
            child: CustomeTextFormField(
              controller: bagsController,
              label: "How many bags of rice do you need?",
              bgColor: primaryLightGrey.withOpacity(0.4),
              keyboardType: TextInputType.text,
              textColor: Colors.black,
              borderRadius: 5.0,
            ),
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.only(left: 5.0, right: 20.0),
        child: const Icon(
          CommunityMaterialIcons.plus_box,
          size: 12.0,
        ),
      ),
    ],
  );
}
