import 'package:flutter/material.dart';

List<String> months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

const String appStoreUrl = "https://apps.apple.com/us/app/appname/id1485117463";
const String playStoreUrl =
    "https://play.google.com/store/apps/details?id=com.unboxedkart";

getCrossAxisCount(double width) {
  // String width = window.physicalSize;
  if (width < 480) {
    return 2;
  } else if (width > 480 && width <= 767) {
    return 3;
  } else if (width > 767 && width <= 1024) {
    return 4;
  } else {
    return 6;
  }
}

getColumnCount(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  if (width < 480) {
    return 2;
  } else if (width > 480 && width <= 767) {
    return 2;
  } else if (width > 767 && width <= 1024) {
    return 3;
  } else {
    return 4;
  }
}

class CustomColors {
  static const blue = Color(0xff004aad);
  static const backgroundGrey = Color(0xffF6F6F9);
  static const yellow = Color(0xfffcb711);
}
