import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/placement_quiz/data/models/question_model.dart';

import '../cubits/quiz_cubit.dart';
import '../cubits/quiz_state.dart';

class QuizActionButton extends StatelessWidget {
  final QuestionModel question;
  final QuizState state;

  const QuizActionButton({
    super.key,
    required this.question,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final isCheckType =
        question.type == QuestionType.trueFalse || question.type == QuestionType.wordChips;

    return CustomElevatedButton(
      text: isCheckType ? QuizStrings.checkAnswer : CommonStrings.sent,
      backgroundColor: state.isButtonEnabled ? AppColors.brandPrimary : AppColors.borderDefault,
      textColor: AppColors.textOnBrand,
      onTap: () {
        if (state.isButtonEnabled) {
          context.read<QuizCubit>().submitAnswer();
        }
      },
    );
  }
}
