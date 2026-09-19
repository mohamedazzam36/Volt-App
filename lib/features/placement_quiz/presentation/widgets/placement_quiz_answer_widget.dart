import 'package:flutter/material.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/multiple_choice_question_widget.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/true_false_question_widget.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/placement_quiz_cubit.dart';

class PlacementQuizAnswerWidget extends StatelessWidget {
  const PlacementQuizAnswerWidget({
    super.key,
    required this.type,
    required this.state,
    required this.cubit,
  });

  final QuestionType type;
  final PlacementQuizQuestion state;
  final PlacementQuizCubit cubit;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      QuestionType.trueFalse => TrueFalseQuestionWidget(
        options: state.question.options ?? [],
        selectedOptionId: state.selectedOptionId,
        onSelect: cubit.selectAnswer,
      ),
      QuestionType.multipleChoice => MultipleChoiceQuestionWidget(
        options: state.question.options ?? [],
        selectedOptionId: state.selectedOptionId,
        onSelect: cubit.selectAnswer,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
