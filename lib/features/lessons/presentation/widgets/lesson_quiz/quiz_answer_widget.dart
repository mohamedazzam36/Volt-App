import 'package:flutter/material.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/essay_question_widget.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/multiple_choice_question_widget.dart';
import 'package:volt/core/shared_widgets/quiz_widgets/true_false_question_widget.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_quiz_cubit/lesson_quiz_cubit.dart';

class QuizAnswerWidget extends StatelessWidget {
  const QuizAnswerWidget({
    super.key,
    required this.type,
    required this.state,
    required this.cubit,
  });

  final QuestionType type;
  final LessonQuizQuestion state;
  final LessonQuizCubit cubit;

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
      QuestionType.essay => EssayQuestionWidget(
        essayText: state.essayText,
        onChanged: cubit.updateEssay,
        onSubmit: state.essayText.trim().isNotEmpty ? cubit.nextQuestion : null,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
