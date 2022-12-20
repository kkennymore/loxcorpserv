import 'package:flutter/material.dart';
import 'package:loxcorpserv/public/colors.dart';
import 'package:loxcorpserv/public/radius.dart';
import 'package:loxcorpserv/public/sizes.dart';
import 'package:loxcorpserv/public/strings.dart';
import 'package:loxcorpserv/state_management/date_picker_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DatePickerInput extends StatelessWidget {
  final TextEditingController? datePickController;
  final String? label;
  DatePickerInput({
    required this.datePickController,
    this.label,
    Key? key,
  }) : super(key: key);
  DateTime getDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<DatePickerProvider>(context);
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: MaterialButton(
        onPressed: () {
          showDatePicker(
              context: context,
              initialDate:
                  datePickController!.text.isEmpty ? DateTime.now() : getDate,
              firstDate: DateTime(1922),
              lastDate: DateTime.now(),
              builder: (BuildContext context, child) {
                return Theme(
                  data: ThemeData().copyWith(
                    buttonTheme: const ButtonThemeData(
                      buttonColor: primaryColor,
                      textTheme: ButtonTextTheme.primary,
                    ),
                    colorScheme: const ColorScheme.light(
                      //======light theme=======
                      primary: primaryColor,
                      onPrimary: primaryColor,
                      surface: primaryColor,
                      onSurface: primaryColor,
                      secondary: primaryColor,
                      onSecondary: primaryColor,
                      primaryContainer: primaryColor,
                    ),
                  ),
                  child: child!,
                );
              }).then((value) {
            datePickController!.text = DateFormat("MM/dd/yyyy").format(value!);
            getDate = value;
            prov.render();
          });
        },
        height: 47.0,
        shape: OutlineInputBorder(
          borderSide: BorderSide(
            color: primaryTextColor.withOpacity(0.2),
            width: 0.0,
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(formInputBorderRadius)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                datePickController!.text.isEmpty
                    ? dateOfBirth
                    : datePickController!.text.toString(),
                style: TextStyle(
                  color: Colors.black54.withOpacity(0.4),
                  fontSize: textInputFontSize - 3,
                ),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.date_range,
              color: Colors.grey[500],
              size: iconSize - 2,
            ),
          ],
        ),
      ),
    );
  }
}
