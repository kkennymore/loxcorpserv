import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/custom_text_form_field.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/public/colors.dart';


class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final currentLocationController = TextEditingController();
  final bagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
              heightBoxSize(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
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
