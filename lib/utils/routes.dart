import 'package:contact_app/views/addcontact/screen/addcontact_screen.dart';
import 'package:contact_app/views/contact/screen/contact_screen.dart';
import 'package:contact_app/views/detail/screen/detail_screen.dart';
import 'package:contact_app/views/hide/screen/hidedetail_page.dart';
import 'package:contact_app/views/hideDetail/hidedetail_page.dart';
import 'package:flutter/cupertino.dart';

class AllRoutes
{
  static String contact = "contact";
  static String addcontact = "addcontact";
  static String detail = "detail";
  static String hide = "hide";
  static String hidedetail = "hidedetail";

  static Map<String,WidgetBuilder> AppRoutes =
  {
    "contact" : (context) => const ContactScreen(),
    "addcontact" : (context) => const AddContactScreen(),
    "detail" : (context) => const DetailScreen(),
    "hide" : (context) => const HidePage(),
    "hidedetail" : (context) => const HideDetailPage(),
  };

}