import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/lessons/presentation/widgets/semi_circle_progress.dart';
import 'package:volt/features/lessons/presentation/widgets/stat_card_widget.dart';
import 'package:volt/features/lessons/presentation/widgets/xp_card_widget.dart';

class LessonResultsView extends StatelessWidget {
  final String robotImagePath;
  final double percentage;
  final int correctAnswers;
  final int incorrectAnswers;
  final int xpGained;
  final VoidCallback onRetryPressed;
  final VoidCallback onContinuePressed;
  final VoidCallback onEssayAnswersPressed;

  const LessonResultsView({
    super.key,
    required this.robotImagePath,
    required this.percentage,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.xpGained,
    required this.onRetryPressed,
    required this.onContinuePressed,
    required this.onEssayAnswersPressed,
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.01),
                SemiCircleProgressWidget(
                  percentage: percentage,
                  size: screenWidth * 0.5,
                  progressColor: AppColors.statusSuccess,
                ),
                SizedBox(height: screenHeight * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StatCardWidget(
                      value: correctAnswers.toString(),
                      label: 'اجابات صحيحة',
                      valueColor: AppColors.statusSuccess,
                      width: screenWidth * 0.41,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    StatCardWidget(
                      value: incorrectAnswers.toString(),
                      label: 'اجابات خاطئة',
                      valueColor: AppColors.statusError,
                      width: screenWidth * 0.41,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    XpCardWidget(
                      xpValue: xpGained,
                      textColor: AppColors.textSuccess,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Image.asset(
                      Assets.images.onboarding2.path,
                      height: screenWidth * 0.7,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        width: double.infinity,
                        backgroundColor: AppColors.brandPrimary,
                        onTap: onContinuePressed,
                        text: 'متابعة',
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: CustomElevatedButton(
                        width: double.infinity,
                        backgroundColor: AppColors.statusSuccess,
                        onTap: onRetryPressed,
                        text: 'اعد المحاولة',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.015),
                CustomElevatedButton(
                  width: double.infinity,
                  backgroundColor: AppColors.statusSuccess,
                  onTap: onEssayAnswersPressed,
                  text: 'عرض اجابات الاسئلة المقالية',
                ),
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
