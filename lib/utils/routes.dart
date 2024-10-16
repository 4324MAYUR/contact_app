import 'package:contact_app/views/addcontact/screen/addcontact_screen.dart';
import 'package:contact_app/views/contact/screen/contact_screen.dart';
import 'package:flutter/cupertino.dart';

class AllRoutes
{
  static String contact = "contact";
  static String addcontact = "addcontact";

  static Map<String,WidgetBuilder> AppRoutes =
  {
    "contact" : (context) => const ContactScreen(),
    "addcontact" : (context) => const AddContactScreen(),
  };

}