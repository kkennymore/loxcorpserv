import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loxcorpserv/components/animation.dart';
import 'package:loxcorpserv/components/custom_button.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/config/config.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/image_paths.dart';
import 'package:loxcorpserv/screens/auth_screens/login_screen.dart';
import 'package:loxcorpserv/screens/main_screens/confirm_payment.dart';
import 'package:loxcorpserv/screens/main_screens/saved_places.dart';
import 'package:loxcorpserv/services/local_storage.dart';
import 'package:loxcorpserv/services/products_services.dart';
import 'package:loxcorpserv/services/users_auth_services.dart';

class SelectRide extends StatefulWidget {
  const SelectRide({super.key});

  @override
  State<SelectRide> createState() => _SelectRideState();
}

class _SelectRideState extends State<SelectRide> {
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
                  confirmRideButton(context),
                  heightBoxSize(height: 30.0),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(CommunityMaterialIcons.chevron_left),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: MaterialButton(
                          onPressed: () async {
                            await UserAuthService().logout(context);
                            /**login successfully */
                            toastSnackBar(
                              context: context,
                              textMessage: "Logged out successfully",
                              isSuccess: true,
                            );
                            /*redirect user to login */
                            Navigator.push(
                              context,
                              PageTransitionRoute(
                                child: const LoginScreen(),
                                duration: pageTransitionDuration,
                                direction: PageAnimateDirection.left,
                              ),
                            );
                          },
                          child: const Text("Logout"),
                        ),
                      ),
                    ],
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

  Container confirmRideButton(context) {
    return Container(
      width: MediaQuery.of(context).size.width - 45,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(30.0),
        ),
        border: Border.all(width: 1.5, color: primaryColor),
        color: primaryColor,
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransitionRoute(
              child: const SelectRide(),
              duration: pageTransitionDuration,
              direction: PageAnimateDirection.right,
            ),
          );
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Confirm your ride",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Container paymentButton(context) {
  return Container(
    padding: const EdgeInsets.only(),
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          PageTransitionRoute(
            child: const ConfirmPayment(),
            duration: pageTransitionDuration,
            direction: PageAnimateDirection.right,
          ),
        );
      },
      leading: const Icon(
        CommunityMaterialIcons.credit_card,
        color: primaryColor,
      ),
      title: const Text(
        "Cash/Credit",
        style: TextStyle(
          color: primaryColor,
          fontSize: 16.0,
        ),
      ),
      trailing: Icon(
        CommunityMaterialIcons.chevron_right,
        color: Colors.black.withOpacity(0.1),
      ),
    ),
  );
}

Container productsSection(context) {
  return Container(
    padding: const EdgeInsets.only(),
    height: 240.0,
    child: FutureBuilder(
      future: ProductsService().getProducts(),
      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            padding: const EdgeInsets.only(),
            width: MediaQuery.of(context).size.width,
            height: 30.0,
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              color: primaryColor.withOpacity(0.1),
              minHeight: 2.0,
            ),
          );
        }

        return ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                "${snapshot.data[index]['image_url'].toString()}${snapshot.data[index]['images'][0]['image_name'].toString()}",
                fit: BoxFit.contain,
                errorBuilder: (BuildContext ctx, child, err) {
                  return Image.asset(
                    cornProduct,
                    fit: BoxFit.contain,
                    height: 30.0,
                    width: 30.0,
                  );
                },
                height: 30.0,
                width: 30.0,
              ),
              title: Text(
                "1 ${snapshot.data[index]['product_name'].toString()}",
                style: const TextStyle(
                  fontSize: 18.0,
                  color: primaryColor,
                ),
              ),
              subtitle: Row(
                children: [
                  const Icon(
                    CommunityMaterialIcons.currency_ngn,
                    size: 14,
                  ),
                  Text(
                    "${snapshot.data[index]['product_price'].toString()}",
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
              trailing: const Text(
                "2m away",
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            );
          },
        );
      },
    ),
  );
}

Container mapSection(context) {
  return Container(
    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 200.0),
    height: 260.0,
    width: MediaQuery.of(context).size.width,
    color: Colors.black12,
    child: const Text(
      "google map here",
      textAlign: TextAlign.center,
    ),
  );
}
