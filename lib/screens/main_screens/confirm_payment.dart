import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/image_paths.dart';

class ConfirmPayment extends StatefulWidget {
  const ConfirmPayment({super.key});

  @override
  State<ConfirmPayment> createState() => _ConfirmPaymentState();
}

class _ConfirmPaymentState extends State<ConfirmPayment> {
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
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
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mapSection(context),
                  heightBoxSize(height: 10.0),
                  Container(
                    padding: const EdgeInsets.only(),
                    child: const Text(
                      "Price Estimates",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  heightBoxSize(height: 10.0),
                  horizontalDivider(
                    lineColor: Colors.black12.withOpacity(0.09),
                    width: MediaQuery.of(context).size.width,
                  ),
                  productsSection(context),
                  heightBoxSize(height: 20.0),
                  horizontalDivider(
                    lineColor: Colors.black12.withOpacity(0.09),
                    width: MediaQuery.of(context).size.width,
                  ),
                  heightBoxSize(height: 0.0),
                  paymentButton(context),
                  heightBoxSize(height: 0.0),
                  horizontalDivider(
                    lineColor: Colors.black12.withOpacity(0.09),
                    width: MediaQuery.of(context).size.width,
                  ),
                  heightBoxSize(height: 30.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container paymentButton(context) {
  return Container(
    padding: const EdgeInsets.only(),
    child: MaterialButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            CommunityMaterialIcons.plus,
            color: primaryColor,
            size: 12.0,
          ),
          Text(
            "Add new card",
            style: TextStyle(
              color: primaryColor,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ),
  );
}

Container productsSection(context) {
  return Container(
    padding: const EdgeInsets.only(),
    height: 240.0,
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: index == 1
              ? const Icon(
                  CommunityMaterialIcons.wallet,
                  color: primaryColor,
                )
              : index == 2
                  ? const Icon(
                      CommunityMaterialIcons.cash,
                      color: primaryColor,
                    )
                  : const Icon(
                      CommunityMaterialIcons.credit_card,
                      color: primaryColor,
                    ),
          title: index == 1
              ? const Text(
                  "Wallet",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : index == 2
                  ? const Text(
                      "Cash",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Text(
                      "Visa ******111",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          trailing: index == 0
              ? const Icon(
                  CommunityMaterialIcons.plus_circle,
                  color: primaryColor,
                  size: 10.0,
                )
              : Container(
                  child: Text(""),
                ),
        );
      },
    ),
  );
}

Container mapSection(context) {
  return Container(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 200.0),
    height: 300.0,
    width: MediaQuery.of(context).size.width,
    color: Colors.black12,
    child: Text(
      "google map here",
      textAlign: TextAlign.center,
    ),
  );
}
