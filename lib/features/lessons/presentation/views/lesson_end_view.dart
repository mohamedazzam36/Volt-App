import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_question_action_button.dart';

class LessonEndView extends StatelessWidget {
  final VoidCallback onShowResultsPressed;

  const LessonEndView({
    super.key,
    required this.onShowResultsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.backgroundLevel1.path),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.03,
            ),
            child: Column(
              children: [
                // Spacer علوي مرن بنسبة أكبر شوية لضبط المنتصف البصري
                const Spacer(flex: 4),
                
                // الروبوت في النص تماماً مع إزاحة بسيطة جداً لتعويض مساحة فقاعة الكلام لو وجدت
                Transform.translate(
                  offset: Offset(0, -screenHeight * 0.08),
                  child: Center(
                    child: SpeakingRobot(
                      message: "وصلنا لنهاية الدرس",
                      robotImagePath: Assets.images.greenRobotCelebrating.path,
                      isMessageOneLine: true,
                      spaceAfterMessage: 16,
                      robotWidth: screenWidth * 0.58, 
                      messageShiftingRatio: .3,
                    ),
                  ),
                ),

                // مسافة بسيطة جداً وثابتة تحت الروبوت وقبل الزرار
                SizedBox(height: screenHeight * 0.04),

                // زر عرض النتائج
                LessonQuestionActionButton(
                  text: "عرض النتائج",
                  onTap: onShowResultsPressed,
                  backgroundColor: AppColors.brandSecondaryGreen,
                ),
                
                // Spacer سفلي عشان يوازن الشاشة
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}