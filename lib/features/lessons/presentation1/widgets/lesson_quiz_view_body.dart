import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/essay_question_widget.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/multiple_choice_question_widget.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/true_false_question_widget.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/lessons/presentation1/cubits/lesson_content_cubit/lesson_quiz_cubit/lesson_quiz_cubit.dart';

class LessonQuizViewBody extends StatelessWidget {
  const LessonQuizViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonQuizCubit, LessonQuizState>(
      builder: (context, state) => switch (state) {
        LessonQuizLoading() => const Center(child: CircularProgressIndicator()),
        LessonQuizError() => Center(
          child: Text(
            state.message,
            style: AppStyles.semiBold14.copyWith(color: AppColors.statusError),
            textAlign: TextAlign.center,
          ),
        ),
        LessonQuizQuestion() => _QuizQuestionBody(state: state),
        _ => const Center(
          child: CircularProgressIndicator(),
        ),
      },
    );
  }
}

class _QuizQuestionBody extends StatelessWidget {
  final LessonQuizQuestion state;

  const _QuizQuestionBody({required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LessonQuizCubit>();
    final question = state.question;
    final isRetry = cubit.isRetryMode;

    return CustomScrollView(
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
            message: question.questionText ?? 'السؤال غير متاح',
            robotImagePath: Assets.images.authRobotThinking.path,
            robotWidth: 130,
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
                    Icon(Icons.lightbulb_rounded, color: AppColors.brandPrimary, size: 20),
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
          child: _buildAnswerWidget(context, cubit, question.questionType),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 16)),

        if (!isRetry)
          SliverToBoxAdapter(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: _HelpButton(
                onTap: () {},
              ),
            ),
          ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        if (question.questionType != QuestionType.essay)
          SliverToBoxAdapter(
            child: CustomElevatedButton(
              width: double.infinity,
              text: cubit.isLastQuestion ? 'إنهاء' : 'التالي',
              onTap: _canProceed(question.questionType)
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

        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _buildAnswerWidget(
    BuildContext context,
    LessonQuizCubit cubit,
    QuestionType type,
  ) {
    return switch (type) {
      QuestionType.trueFalse => TrueFalseQuestionWidget(
        selectedValue: state.selectedBool,
        onSelect: cubit.selectBool,
      ),
      QuestionType.multipleChoice => MultipleChoiceQuestionWidget(
        options: state.question.options ?? [],
        selectedOptionId: state.selectedOptionId,
        onSelect: cubit.selectOption,
      ),
      QuestionType.essay => EssayQuestionWidget(
        essayText: state.essayText,
        onChanged: cubit.updateEssay,
        onSubmit: state.essayText.trim().isNotEmpty ? cubit.nextQuestion : null,
      ),
      _ => const SizedBox.shrink(),
    };
  }

  bool _canProceed(QuestionType type) {
    return switch (type) {
      QuestionType.trueFalse => state.selectedBool != null,
      QuestionType.multipleChoice => state.selectedOptionId != null,
      _ => false,
    };
  }
}

class _HelpButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HelpButton({required this.onTap});

  @override
  State<_HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<_HelpButton> {
  double _bottom = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _bottom = 0),
      onTapUp: (_) {
        setState(() => _bottom = 3);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _bottom = 3),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.brandPrimary.withAlpha(80),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: _bottom),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            'مساعدة',
            style: AppStyles.bold14.copyWith(color: AppColors.textOnBrand),
          ),
        ),
      ),
    );
  }
}
