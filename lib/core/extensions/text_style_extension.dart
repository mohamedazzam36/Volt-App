import 'package:flutter/material.dart';

import '../utils/size_config.dart';

extension ResponsiveTextStyle on TextStyle {
  TextStyle responsive(BuildContext context, {double? fontSize}) {
    return copyWith(
      fontSize: SizeConfig.getResponsiveFontSize(
        context,
        fontSize: fontSize ?? this.fontSize ?? 14,
      ),
    );
  }
}
