import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';

class QuizErrorScreen extends StatelessWidget {
  final VoidCallback? onTap;

  const QuizErrorScreen({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Scaffold(
        backgroundColor: AppColors.surfaceOrangeSoft, // لون الخلفية الوردي الفاتح
        body: SafeArea(
          child: Center(
            child: SpeakingRobot(
              message: QuizStrings.ohNoError,
              robotImagePath: Assets.images.authRobotWorried.path, // صورة الروبوت الحزين/القلق
              isMessageOneLine: true,
              messageShiftingRatio: 0.5,
              spaceAfterMessage: 16,
            ),
          ),
        ),
      ),
    );
  }
}
