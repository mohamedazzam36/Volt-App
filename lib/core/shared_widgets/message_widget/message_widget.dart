import 'package:flutter/material.dart';
import '../../extensions/text_style_extension.dart';
import './message_shape_border.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class MessageWidget extends StatelessWidget {
  final double arrowWidth;
  final double arrowHeight;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final double thresholdHeight;
  final String message;
  final double? fontSize;
  final double? maxWidth;
  final Color? fontColor;
  final bool isOneLine;

  const MessageWidget(
    this.message, {
    super.key,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.borderRadius = 16.0,
    this.borderColor = AppColors.borderSubtle,
    this.borderWidth = 2,
    this.thresholdHeight = 65.0,
    this.fontSize,
    this.fontColor,
    this.maxWidth,
    this.isOneLine = true,
  });

  @override
  Widget build(BuildContext context) {
    final messageStyle = AppStyles.semiBold12
        .responsive(context)
        .copyWith(
          color: fontColor ?? const Color(0xFF132331),
          fontFamily: 'Cairo',
          fontSize: fontSize ?? 12,
          height: 16 / 12,
        );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      constraints: BoxConstraints(maxWidth: maxWidth ?? 250),
      decoration: ShapeDecoration(
        color: AppColors.textOnBrand,
        shadows: [
          BoxShadow(
            color: Colors.black.withAlpha(80),
            blurRadius: 2,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
        ],
        shape: MessageShapeBorder(
          arrowHeight: arrowHeight,
          borderRadius: borderRadius,
          borderColor: borderColor,
          borderWidth: borderWidth,
          thresholdHeight: thresholdHeight,
          arrowWidth: arrowWidth,
        ),
      ),
      child: isOneLine
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                message,
                style: messageStyle,
              ),
            )
          : Text(
              message,
              style: messageStyle,
            ),
    );
  }
}
