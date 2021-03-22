import 'package:flutter/material.dart';

class Styles {

  static final bannerText = TextStyle(
    fontSize: 36
  );

  static double padding(context, double landSpace, double portSpace) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      return MediaQuery.of(context).size.height * landSpace;
    } else {
      return MediaQuery.of(context).size.height * portSpace;
    }
  }

  static double adjustHeight(context, double heightFactor) {
    return MediaQuery.of(context).size.height * heightFactor;
  }
}
