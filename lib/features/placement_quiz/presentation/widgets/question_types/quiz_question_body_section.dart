import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/question_model.dart';
import '../../cubits/quiz_cubit.dart';
import '../../cubits/quiz_state.dart';
import '../quiz_text_field.dart';
import 'image_choice_quiz_view.dart';
import 'text_choice_quiz_view.dart';
import 'true_false_quiz_view.dart';
import 'word_chips_quiz_view.dart';

class QuizQuestionBodySection extends StatelessWidget {
  final QuestionModel question;
  final QuizState state;
  final TextEditingController answerController;

  const QuizQuestionBodySection({
    super.key,
    required this.question,
    required this.state,
    required this.answerController,
  });

  Offset _calculateOffset(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    if (state.currentQuestionIndex == 3 || state.currentQuestionIndex == 4) {
      return Offset(0, -screenWidth * 0.13);
    }
    if (question.type == QuestionType.trueFalse) {
      return Offset(0, -screenWidth * 0.02);
    }
    return Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    final offset = _calculateOffset(context);
    final child = _buildContent(context);

    if (offset == Offset.zero) return child;

    return Transform.translate(
      offset: offset,
      child: child,
    );
  }

  Widget _buildContent(BuildContext context) {
    final cubit = context.read<QuizCubit>();

    switch (question.type) {
      case QuestionType.imageChoice:
        return ImageChoiceQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: cubit.selectOption,
        );

      case QuestionType.mcq:
        return TextChoiceQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: cubit.selectOption,
        );

      case QuestionType.trueFalse:
        return TrueFalseQuizView(
          selectedValue: state.selectedBoolValue,
          onValueSelected: cubit.selectBool,
        );

      case QuestionType.fillInBlank:
        return QuizTextField(
          controller: answerController,
        );

      case QuestionType.wordChips:
        return WordChipsQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: cubit.selectOption,
        );
    }
  }
}
