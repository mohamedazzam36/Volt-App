import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class QuizQuestionSection extends StatelessWidget {
  final String message;

  const QuizQuestionSection({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final robotWidth = screenWidth * 0.28;
    final messageStyle = AppStyles.semiBold14
        .responsive(context)
        .copyWith(
          color: AppColors.textPrimary,
          fontSize: 16,
        );

    return DefaultTextStyle(
      style: messageStyle,
      child: SpeakingRobot(
        message: message,
        robotImagePath: Assets.images.voltActiveMode.path,
        isMessageOneLine: false,
        messageShiftingRatio: 0.5,
        spaceAfterMessage: 8,
        robotWidth: robotWidth,
      
      ),
    );
  }
}
