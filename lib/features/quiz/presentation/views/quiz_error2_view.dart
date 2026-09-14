import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';

class QuizError2View extends StatelessWidget {
  final VoidCallback onContinue;
  final String? message;

  const QuizError2View({
    super.key,
    required this.onContinue,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceSubtle,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // الروبوت مع بالون الحوار
              SpeakingRobot(
                message: message ?? QuizStrings.dontWorryNextTimeEasier,
                robotImagePath: Assets.images.greenRobotStandingSad.path,
                isMessageOneLine: true,
                messageShiftingRatio: 0.5,
                spaceAfterMessage: 25,
              ),

              const Spacer(flex: 2),

              // زر المتابعة الأصفر (باستخدام CustomElevatedButton)
              CustomElevatedButton(
                text: CommonStrings.continueAction,
                backgroundColor: AppColors.brandSecondaryYellow, // اللون الأصفر البارز
                textColor: AppColors.textOnBrand, // لون النص على الزر
                width: double.infinity,
                onTap: onContinue,
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
