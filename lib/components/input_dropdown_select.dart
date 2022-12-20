import 'package:flutter/material.dart';
import 'package:loxcorpserv/components/functions.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/state_management/drop_down_provider.dart';
import 'package:provider/provider.dart';

class InputDropDownSelect extends StatelessWidget {
  final TextEditingController? selectedValue;
  final String? labelText;
  final Future? futureBuilderFunc;
  final bool? isAssignToFunction;
  final double? iconSize;
  InputDropDownSelect(
    this.selectedValue, {
    this.labelText,
    this.futureBuilderFunc,
    this.isAssignToFunction,
    this.iconSize,
    Key? key,
  }) : super(key: key);
  String? dropValue;
  @override
  Widget build(BuildContext context) {
    var dropdownProv = Provider.of<DropDownProvider>(context);
    return FutureBuilder(
      future: futureBuilderFunc,
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          return Container(
            height: 47.0,
            decoration: ShapeDecoration(
                shape: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: primaryColor,
                  width: 1.0),
              borderRadius:
                  BorderRadius.all(Radius.circular(formInputBorderRadius)),
            )),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String?>(
                icon: Container(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: primaryColor,
                    size: iconSize,
                  ),
                ),
                isExpanded: true,
                hint: Container(
                  padding: const EdgeInsets.only(left: 17.0, right: 13.0),
                  child: Text(
                    labelText.toString(),
                    style: TextStyle(
                      color:  primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: textInputFontSize,
                    ),
                  ),
                ),
                value: dropValue,
                items: snap.data.map<DropdownMenuItem<String?>>((data) {
                  return DropdownMenuItem<String?>(
                    value: data,
                    child: Container(
                      padding: const EdgeInsets.only(left: 17.0, right: 13.0),
                      child: Text(
                        data,
                        style: TextStyle(
                          color:  primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: textInputFontSize,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) async {
                  dropValue = value.toString();
                  selectedValue!.text = dropValue.toString();
                  dropdownProv.render();
                },
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return circularProgress(
            isLinear: true,
            textLabel: "Loading...",
            isBgTransparent: true,
          );
        }
      },
    );
  }
}
