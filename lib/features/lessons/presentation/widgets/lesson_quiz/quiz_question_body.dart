import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/lessons/data/models/hint_response_model.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_quiz_cubit/lesson_quiz_cubit.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz/quiz_answer_widget.dart';

class QuizQuestionBody extends StatelessWidget {
  final LessonQuizQuestion state;

  const QuizQuestionBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LessonQuizCubit>();
    final question = state.question;
    final isRetry = cubit.isRetryMode;

    return BlocListener<LessonQuizCubit, LessonQuizState>(
      // استمع بس لما pendingHint تجي جديدة
      listenWhen: (prev, curr) =>
          curr is LessonQuizQuestion &&
          curr.pendingHint != null &&
          (prev is! LessonQuizQuestion || prev.pendingHint != curr.pendingHint),
      listener: (context, s) {
        if (s is LessonQuizQuestion && s.pendingHint != null) {
          _showHintDialog(context, s.pendingHint!, cubit);
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'سؤال ${state.questionIndex + 1} من ${state.totalQuestions}',
                style: AppStyles.medium12.copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SpeakingRobot(
              message: question.questionText ?? LessonStrings.questionUnavailable,
              robotImagePath: Assets.images.authRobotThinking.path,
              robotWidth: 130,
              messageShiftingRatio: 0.65,
              isMessageOneLine: false,
              spaceAfterMessage: 12,
            ),
          ),

          if (isRetry && question.currentHint != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary.withAlpha(20),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.brandPrimary.withAlpha(80)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_rounded,
                          color: AppColors.brandPrimary, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          question.currentHint!,
                          style: AppStyles.medium12.copyWith(color: AppColors.brandPrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (question.imageUrl != null && question.imageUrl!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: question.imageUrl!,
                    fit: BoxFit.contain,
                    placeholder: (_, _) => const SizedBox(height: 40),
                    errorWidget: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          SliverToBoxAdapter(
            child: QuizAnswerWidget(
              type: question.questionType,
              state: state,
              cubit: cubit,
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // ─── زرار المساعدة – يتعطل أثناء اللودينج ────────────────────
          if (!isRetry)
            SliverToBoxAdapter(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: AbsorbPointer(
                  absorbing: state.isHintLoading,
                  child: CustomElevatedButton(
                    text: state.isHintLoading ? '...' : LessonStrings.help,
                    width: 150,
                    backgroundColor: state.isHintLoading
                        ? AppColors.textSecondary
                        : null, // اللون الافتراضي
                    onTap: state.isHintLoading
                        ? null
                        : () => cubit.fetchHint(questionId: question.questionId),
                  ),
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          if (question.questionType != QuestionType.essay)
            SliverToBoxAdapter(
              child: AbsorbPointer(
                // امنع الضغط على "التالي/إنهاء" أثناء جلب الـ hint
                absorbing: state.isHintLoading,
                child: CustomElevatedButton(
                  width: double.infinity,
                  text: cubit.isLastQuestion ? CommonStrings.finish : CommonStrings.next,
                  onTap: _canProceed(question.questionType) && !state.isHintLoading
                      ? () {
                          if (cubit.isLastQuestion) {
                            cubit.submitQuiz();
                          } else {
                            cubit.nextQuestion();
                          }
                        }
                      : null,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  bool _canProceed(QuestionType type) {
    return switch (type) {
      QuestionType.trueFalse || QuestionType.multipleChoice => state.selectedOptionId != null,
      _ => false,
    };
  }

  // ─── Hint Popup Dialog ────────────────────────────────────────────────────
  void _showHintDialog(
    BuildContext context,
    HintResponseModel hint,
    LessonQuizCubit cubit,
  ) {
    // امسح الـ pendingHint فور ما نفتح الـ dialog
    cubit.clearPendingHint();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: AppColors.surfaceSubtle,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─ Header ─
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary.withAlpha(25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lightbulb_rounded,
                      color: AppColors.brandPrimary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      LessonStrings.aiHint,
                      style: AppStyles.semiBold16.copyWith(color: AppColors.brandPrimary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 16),

              // ─ Hint Text ─
              Text(
                hint.hint ?? LessonStrings.hintUnavailable,
                style: AppStyles.medium14,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // ─ Hints Remaining ─
              Text(
                '${LessonStrings.hintsRemaining} ${hint.hintsRemaining}',
                style: AppStyles.medium12.copyWith(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 20),

              // ─ OK Button ─
              CustomElevatedButton(
                text: CommonStrings.ok,
                width: double.infinity,
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
