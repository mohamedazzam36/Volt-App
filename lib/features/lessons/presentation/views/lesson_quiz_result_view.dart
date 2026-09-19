import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/lessons/presentation/views/lesson_quiz_view.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz_result/score_gauge.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz_result/stat_card.dart';

class LessonQuizResultView extends StatelessWidget {
  const LessonQuizResultView({
    super.key,
    required this.result,
    this.retryAttemptNumber = 0,
  });

  final QuizAttemptResultModel result;
  final int retryAttemptNumber;

  static const int _maxRetries = 3;

  @override
  Widget build(BuildContext context) {
    final scorePercent = result.scorePercentage;
    final isGood = scorePercent >= 60;
    final hasRetry = result.retryQuestions?.isNotEmpty == true;
    final canRetry = hasRetry && retryAttemptNumber < _maxRetries;

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
                          : Assets.images.authRobotThinking.path,
                      height: 180,
                    ),
                    Positioned(
                      right: -20,
                      top: 60,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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

                if (hasRetry)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      retryAttemptNumber >= _maxRetries
                          ? LessonStrings.retriesExhausted
                          : 'المحاولة ${retryAttemptNumber + 1} من $_maxRetries',
                      style: AppStyles.medium12
                          .responsive(context)
                          .copyWith(
                            color: retryAttemptNumber >= _maxRetries
                                ? AppColors.statusError
                                : AppColors.textSecondary,
                          ),
                    ),
                  ),

                const Spacer(),

                Row(
                  children: [
                    if (canRetry) ...[
                      Expanded(
                        child: CustomElevatedButton(
                          text: LessonStrings.retryQuiz,
                          backgroundColor: const Color(0xFF5C9E54),
                          width: double.infinity,
                          onTap: () {
                            context.pushReplacementNamed(
                              Routes.lessonQuizRetry,
                              arguments: LessonQuizRetryArgs(
                                quizId: result.quizId,
                                previousAttemptId: result.attemptId,
                                retryAttemptNumber: retryAttemptNumber + 1,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: CustomElevatedButton(
                        text: CommonStrings.continueAction,
                        backgroundColor: const Color(0xFF55A6F8),
                        width: double.infinity,
                        onTap: () {
                          context.pushNamedAndRemoveAll(
                            Routes.mainLayout,
                          );
                        },
                      ),
                    ),
                  ],
                ),

                if (result.essayResults?.isNotEmpty == true) ...[
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    text: LessonStrings.showEssayAnswers,
                    backgroundColor: const Color(0xFF5C9E54),
                    width: double.infinity,
                    onTap: () {},
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
