import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';

import '../../data/models/lesson_question_item_model.dart';
import 'lesson_action_button.dart';

class LessonCardBody extends StatelessWidget {
  final LessonItemModel item;
  final String robotImagePath;
  final String buttonText;
  final VoidCallback onNextPressed;
  final double? robotWidth;

  const LessonCardBody({
    super.key,
    required this.item,
    required this.robotImagePath,
    required this.buttonText,
    required this.onNextPressed,
    this.robotWidth,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasImage = item.contentImagePath != null && item.contentImagePath!.isNotEmpty;
    final double screenWidth = MediaQuery.sizeOf(context).width;
    final double horizontalPadding = screenWidth < 360 ? 16 : 20;
    final double contentImageHeight = screenWidth < 360
        ? 90
        : screenWidth < 430
        ? 110
        : 130;
    final double verticalSpacing = screenWidth < 360 ? 16 : 24;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        children: [
          const Spacer(),

          // 1. الروبوت مع الرسالة في نفس كتلة النص تماماً
          SpeakingRobot(
            message: item.message,
            robotImagePath: robotImagePath,
            isMessageOneLine: false,
            robotWidth: robotWidth,
            messageShiftingRatio: 0.5,
            spaceAfterMessage: 2,
            messageHorizontalOffset: 0,
          ),

          // 2. صورة المحتوى من الـ Assets المحلية
          if (hasImage) ...[
            SizedBox(height: verticalSpacing),
            Image.asset(
              item.contentImagePath!,
              height: contentImageHeight,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ],

          SizedBox(height: verticalSpacing),

          // 3. زر التالي/إنهاء
          LessonActionButton(
            text: buttonText,
            onTap: onNextPressed,
            backgroundColor: item.buttonColor ?? const Color(0xFF4CAF50),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
