import 'package:flutter/material.dart';

abstract final class SizeConfig {
  static const double tablet = 800;
  static const double desktop = 1200;

  static double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;

    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double getScaleFactor(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < tablet) {
      return width / 412;
    } else if (width < desktop) {
      return width / 800;
    } else {
      return width / 1400;
    }
  }
}
