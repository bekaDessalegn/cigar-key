import 'package:flutter/material.dart';

class Fonts {
  double text(context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 1.5
            : 1.3
        : .8;
    return sizeFont;
  }

  double textButton(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 1.5
            : 1.1
        : .80;
    return sizeFont;
  }

  double textTitle(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 2.0
            : 1.7
        : 1.1;
    return sizeFont;
  }

  double textStart(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 2.4
            : 2.1
        : 1.8;
    return sizeFont;
  }

  double textScale(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).textScaleFactor;
    return sizeFont;
  }

  double textSmall(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 1.4
            : 1.0
        : 0.75;
    return sizeFont;
  }

  double textverySmall(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 300
        ? MediaQuery.of(context).size.width > 600
            ? 1.0
            : 0.8
        : 0.6;
    return sizeFont;
  }

  double facebookButton(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 300
        ? MediaQuery.of(context).size.width > 600
            ? 0.7
            : 0.5
        : 0.4;
    return sizeFont;
  }

  double preferenceMenu(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 300
        ? MediaQuery.of(context).size.width > 600
            ? 0.8
            : 0.6
        : 0.5;
    return sizeFont;
  }

  double textSelect(BuildContext context) {
    double sizeFont;
    sizeFont = MediaQuery.of(context).size.width > 380
        ? MediaQuery.of(context).size.width > 600
            ? 2.0
            : 1.1
        : 0.5;
    return sizeFont;
  }
}
