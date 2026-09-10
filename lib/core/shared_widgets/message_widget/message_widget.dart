import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/shared_widgets/message_widget/message_shape_border.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class MessageWidget extends StatelessWidget {
  final double arrowWidth;
  final double arrowHeight;
  final double borderRadius; // بيطبق على الرسالة الكبيرة فقط
  final Color borderColor;
  final double borderWidth;
  final double thresholdHeight; // الحد الفاصل بين سطرين وأكتر (افتراضياً 65)
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
                style: AppStyles.bold16.responsive(context),
              ),
            )
          : Text(
              message,
              style: AppStyles.bold16.responsive(context),
            ),
    );
  }
}
