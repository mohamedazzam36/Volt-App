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
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';
import 'package:volt/features/placement_quiz/presentation/widgets/placement_quiz_answer_widget.dart';

class PlacementQuizQuestionBody extends StatelessWidget {
  final PlacementQuizQuestion state;

  const PlacementQuizQuestionBody({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PlacementQuizCubit>();
    final question = state.question;

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
            message: question.questionText ?? LessonStrings.questionUnavailable,
            robotImagePath: Assets.images.greenRobotThinking.path,
            robotWidth: 130,
            messageShiftingRatio: 0.65,
            isMessageOneLine: false,
            spaceAfterMessage: 12,
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
          child: PlacementQuizAnswerWidget(
            type: question.questionType,
            state: state,
            cubit: cubit,
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 24)),

        if (question.questionType != QuestionType.essay)
          SliverToBoxAdapter(
            child: CustomElevatedButton(
              width: double.infinity,
              backgroundColor: AppColors.brandSecondaryOrange,
              text: cubit.isLastQuestion ? CommonStrings.finish : CommonStrings.next,
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

  bool _canProceed(QuestionType type) {
    return switch (type) {
      QuestionType.trueFalse || QuestionType.multipleChoice =>
        state.selectedOptionId != null,
      _ => false,
    };
  }
}
