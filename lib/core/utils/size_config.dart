import 'package:flutter/material.dart';

abstract final class SizeConfig {
  // Breakpoints
  static const double tablet = 800;
  static const double desktop = 1200;

  // Responsive Text Scale Factor
  static double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
    double scaleFactor = getScaleFactor(context);
    double responsiveFontSize = fontSize * scaleFactor;

    // حماية الفونت بحد أدنى وأقصى
    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;

    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  static double getScaleFactor(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < tablet) {
      return width / 412; // 412 هو عرض شاشة الموبايل في التصميم
    } else if (width < desktop) {
      return width / 800;
    } else {
      return width / 1400;
    }
  }
}
