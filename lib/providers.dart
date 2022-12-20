
import 'package:loxcorpserv/state_management/auth_provider.dart';
import 'package:loxcorpserv/state_management/button_provider.dart';
import 'package:loxcorpserv/state_management/date_picker_provider.dart';
import 'package:loxcorpserv/state_management/drop_down_provider.dart';
import 'package:loxcorpserv/state_management/searchform_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> myProviders = [
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (context) => ButtonProvider()),
  ChangeNotifierProvider(create:(context) => DatePickerProvider()), 
  ChangeNotifierProvider(create: (context) => DropDownProvider()),
  ChangeNotifierProvider(create: (context) => SearchFormProvider()),
];
