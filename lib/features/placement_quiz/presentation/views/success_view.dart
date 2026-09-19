import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/constants/assets.gen.dart';
import '../../../../../core/shared_widgets/custom_elevated_button.dart';
import '../../../../../core/shared_widgets/speaking_robot.dart';

class QuizSuccessView extends StatelessWidget {
  final String? message;
  final VoidCallback onContinue;

  const QuizSuccessView({
    super.key,
    this.message,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final robotWidth = screenSize.width * 0.52; // حجم الروبوت يتناسب مع عرض الشاشة

    return Scaffold(
      backgroundColor: AppColors.surfaceGreenSoft,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),

                        // الروبوت المتحدث مع رسالة النجاح
                        SpeakingRobot(
                          message: message ?? QuizStrings.looksNotYourFirstTime,
                          robotImagePath: Assets.images.greenRobotCelebrating.path,
                          robotWidth: robotWidth.clamp(160.0, 240.0), // حد أدنى وأقصى لحجم الروبوت
                          isMessageOneLine: true,
                          messageShiftingRatio: 0.5,
                          spaceAfterMessage: 25,
                        ),

                        const Spacer(flex: 1),

                        // زر المتابعة الأخضر
                        CustomElevatedButton(
                          text: CommonStrings.continueAction,
                          backgroundColor: AppColors.brandSecondaryGreen,
                          textColor: AppColors.textOnBrand,
                          onTap: onContinue,
                        ),

                        const Spacer(flex: 2),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
