import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFEDFBF2), // درجة الخلفية الخضراء الفاتحة من Figma
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 3),

              // الروبوت المتحدث مع رسالة النجاح
              SpeakingRobot(
                message: message ?? QuizStrings.looksNotYourFirstTime,
                robotImagePath: Assets.images.voltCelebrating.path,
                robotWidth: 270,
                isMessageOneLine: false,
                messageShiftingRatio: 0.5,
                spaceAfterMessage: 16,
              ),

              const Spacer(flex: 1),

              // زر المتابعة الأخضر
              CustomElevatedButton(
                text: CommonStrings.continueAction,
                color: const Color(0xFF48B452), // الدرجة المحددة لزر النجاح في التصميم
                textColor: Colors.white,
                onTap: onContinue,
              ),

             const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}