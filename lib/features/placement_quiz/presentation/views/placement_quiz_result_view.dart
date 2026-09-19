import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/core/storage/pref_keys.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz_result/score_gauge.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz_result/stat_card.dart';

class PlacementQuizResultView extends StatelessWidget {
  const PlacementQuizResultView({super.key, required this.result});

  final QuizAttemptResultModel result;

  @override
  Widget build(BuildContext context) {
    final scorePercent = result.scorePercentage;
    final isGood = scorePercent >= 60;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.lessonsBackgroundImage1.path),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    LessonStrings.results,
                    style: AppStyles.bold20
                        .responsive(context)
                        .copyWith(
                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                        ),
                  ),
                ),
                const SizedBox(height: 32),

                ScoreGauge(score: scorePercent),
                const SizedBox(height: 32),

                Row(
                  children: [
                    Expanded(
                      child: StatCard(
                        value: result.correctAnswers.toString(),
                        label: LessonStrings.correctAnswers,
                        color: AppColors.brandSecondaryGreen,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: StatCard(
                        value: result.wrongAnswers.toString(),
                        label: LessonStrings.wrongAnswers,
                        color: const Color(0xFFE53935),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      isGood
                          ? Assets.images.authRobotHappy.path
                          : Assets.images.greenRobotThinking.path,
                      height: 180,
                    ),
                    Positioned(
                      right: -20,
                      top: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceDefault,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          '+${result.earnedPoints} XP',
                          style: AppStyles.bold14
                              .responsive(context)
                              .copyWith(color: AppColors.brandSecondaryGreen),
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                CustomElevatedButton(
                  text: CommonStrings.continueAction,
                  backgroundColor: AppColors.brandSecondaryOrange,
                  width: double.infinity,
                  onTap: () async {
                    // 💾 حفظ إن الكويز اتخلص عشان منعملش الريكوست تاني
                    await sl<CacheHelper>().setBool(
                      PrefKeys.isPlacementCompleted,
                      true,
                    );
                    if (context.mounted) {
                      context.pushNamedAndRemoveAll(Routes.mainLayout);
                    }
                  },
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
