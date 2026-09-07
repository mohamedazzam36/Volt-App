import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/message_widget/message_shape_border.dart';

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

  const MessageWidget(
    this.message, {
    super.key,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.borderRadius = 16.0,
    this.borderColor = const Color(0xffDEE3E7),
    this.borderWidth = 2,
    this.thresholdHeight = 65.0,
    this.fontSize,
    this.fontColor,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      constraints: BoxConstraints(maxWidth: maxWidth ?? 250),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
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
      child: Text(
        message,
        style: TextStyle(fontSize: fontSize ?? 12, color: fontColor ?? Colors.black),
      ),
    );
  }
}
