import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/searchform_provider.dart';
import 'package:provider/provider.dart';

class SearchFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? placeholderText;
  final String? type;
  final bool? isShowIcon;
  final double? border;
  final Color? bColor;
  final bool? isPrefixIcon;
  final double? radius;
  final double? iconSize;
  const SearchFormField({
    Key? key,
    this.controller,
    this.placeholderText,
    this.type,
    this.isShowIcon,
    this.border = 0.0,
    this.bColor = Colors.grey,
    this.isPrefixIcon = false,
    this.radius = 0.0,
    this.iconSize = 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<SearchFormProvider>(context);
    return TextField(
      controller: controller,
      onChanged: (value) async {
        prov.render();
      },
      autofocus: false,
      decoration: InputDecoration(
        constraints: const BoxConstraints(
          maxHeight: 46.0,
        ),
        fillColor: bColor,
        filled: true,
        //========Border On Focus=======
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bColor!,
            width: border!,
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
        ),
        //======Set the input border color and radius=========
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: bColor!,
            width: border!,
          ),
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
        ),
        prefixIcon: isPrefixIcon == true
            ? Icon(
                CommunityMaterialIcons.magnify,
                //======Shorthand if and else conditional statement to set the active and inactive button color
                color: primaryBlackColor.withOpacity(0.20),
                size: iconSize,
              )
            : Container(height: 0),
        suffixIcon: isShowIcon == true
            ? IconButton(
                onPressed: () async {
                  prov.textData = '';
                  controller!.clear();
                  prov.render();
                },
                icon: prov.textData != ""
                    ? Icon(
                        CommunityMaterialIcons.close,
                        //======Shorthand if and else conditional statement to set the active and inactive button color
                        color: primaryBlackColor,
                        size: iconSize,
                      )
                    : Container(height: 0),
              )
            : const Text(""),
        //prefixIcon: prefixIcon,
        hintText: placeholderText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        hintStyle: TextStyle(
          color: primaryBlackColor.withOpacity(0.20),
          fontSize: textInputFontSize,
        ),
        labelStyle: TextStyle(
          color: primaryBlackColor.withOpacity(0.20),
          fontSize: textInputFontSize,
        ),
      ),
      cursorHeight: 25.0,
      cursorWidth: 2.0,
      cursorColor: primaryBlackColor,
      style: const TextStyle(
        color: primaryBlackColor,
      ),
    );
  }
}
