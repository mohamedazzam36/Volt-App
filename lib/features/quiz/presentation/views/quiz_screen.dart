import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/quiz/presentation/cubits/quiz_cubit.dart';
import 'package:volt/features/quiz/presentation/widgets/question_types/true_false_quiz_view.dart';

import '../../data/models/question_model.dart';
import '../cubits/quiz_state.dart';
import 'success_view.dart';
import '../widgets/question_types/image_choice_quiz_view.dart';
import '../widgets/question_types/text_choice_quiz_view.dart';
import '../widgets/question_types/word_chips_quiz_view.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_question_section.dart';
import '../widgets/quiz_text_field.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _answerController.addListener(() {
      context.read<QuizCubit>().updateTextAnswer(_answerController.text);
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDefault,
      body: SafeArea(
        child: BlocConsumer<QuizCubit, QuizState>(
          listenWhen: (previous, current) => previous.question?.id != current.question?.id,
          listener: (context, state) {
            _answerController.clear();
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.showSuccess) {
              return QuizSuccessView(
                message: 'أحسنت! الإجابة صحيحة',
                onContinue: () => context.read<QuizCubit>().continueToNextQuestion(),
              );
            }

            final question = state.question;
            if (question == null) return const SizedBox();

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  QuizHeader(
                    currentQuestionIndex: state.currentQuestionIndex,
                    totalQuestions: state.totalQuestions,
                    lives: state.lives,
                    onBackPressed: () => Navigator.maybePop(context),
                    onPreviousQuestion: () => context.read<QuizCubit>().previousQuestion(),
                  ),

                  const Spacer(flex: 1),

                  QuizQuestionSection(
                    message: question.title,
                  ),

                  const Spacer(flex: 1),

                  _buildQuestionBody(context, state, question),

                  const Spacer(flex: 2),

                  CustomElevatedButton(
                    text:
                        question.type == QuestionType.trueFalse ||
                            question.type == QuestionType.wordChips
                        ? QuizStrings.checkAnswer
                        : CommonStrings.sent,
                    color: state.isButtonEnabled ? AppColors.brandPrimary : AppColors.borderDefault,
                    textColor: AppColors.textOnBrand,
                    onTap: () {
                      if (state.isButtonEnabled) {
                        context.read<QuizCubit>().submitAnswer();
                      }
                    },
                  ),

                  const SizedBox(height: 6),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuestionBody(
    BuildContext context,
    QuizState state,
    QuestionModel question,
  ) {
    switch (question.type) {
      case QuestionType.imageChoice:
        return ImageChoiceQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: (id) => context.read<QuizCubit>().selectOption(id),
        );

      case QuestionType.mcq:
        return TextChoiceQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: (id) => context.read<QuizCubit>().selectOption(id),
        );

      case QuestionType.trueFalse:
        return TrueFalseQuizView(
          selectedValue: state.selectedBoolValue,
          onValueSelected: (val) => context.read<QuizCubit>().selectBool(val),
        );

      case QuestionType.fillInBlank:
        return QuizTextField(
          controller: _answerController,
        );

      case QuestionType.wordChips:
        return WordChipsQuizView(
          options: question.options,
          selectedOptionId: state.selectedOptionId,
          onOptionSelected: (id) => context.read<QuizCubit>().selectOption(id),
        );
    }
  }
}
