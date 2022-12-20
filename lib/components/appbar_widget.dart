import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';

@override
AppBar appBarWidget({
  Key? key,
  required BuildContext? context,
  Function? bizPayPopUpMenuItems,
  TabController? chatTabBarController,
  bool? isTitleBgTransparent,
  List<String>? tabText,
  String? title = "Messages",
  bool isShowSearch = true,
}) {
  return isShowSearch
      ? AppBar(
          leading: Container(
            padding: const EdgeInsets.only(left: 30.0),
            width: 15.0,
            child: Image(
              image: AssetImage(""),
              width: 15.0,
            ),
          ),
          leadingWidth: 60.0,
          title: Text(
            title!,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10.0, top: 5.0),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  CommunityMaterialIcons.magnify,
                  color: Colors.black.withOpacity(0.5),
                  size: 25.0,
                ),
              ),
            ),
          ],
          elevation: 1,
          backgroundColor: primaryColor,
          bottom: TabBar(
            controller: chatTabBarController,
            unselectedLabelColor: primaryColor.withOpacity(0.60),
            indicator: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: primaryColor,
                  width: 3.0,
                ),
              ),
            ),
            labelColor: primaryColor,
            tabs: <Widget>[
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText![0].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText[1].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText[2].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        )
      : AppBar(
          leading: Container(),
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  "",
                  width: 30.0,
                ),
              ),
            ],
          ),
          elevation: 0,
          backgroundColor: primaryColor,
          bottom: TabBar(
            controller: chatTabBarController,
            unselectedLabelColor: primaryColor.withOpacity(0.60),
            indicator: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                bottom: BorderSide(
                  color: primaryColor,
                  width: 3.0,
                ),
              ),
            ),
            labelColor: primaryColor,
            tabs: <Widget>[
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText![0].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText[1].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Tab(
                icon: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 65.0,
                  ),
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    tabText[2].toString(),
                    style: TextStyle(
                      color: primaryBlackColor.withOpacity(0.80),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
}
