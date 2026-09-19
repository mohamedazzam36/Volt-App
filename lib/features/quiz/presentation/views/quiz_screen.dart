import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/quiz/presentation/cubits/quiz_cubit.dart';
import 'package:volt/features/quiz/presentation/views/quiz_initial_view.dart';

import '../../data/models/question_model.dart';
import '../cubits/quiz_state.dart';
import '../widgets/question_types/quiz_question_body_section.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_question_section.dart';
import 'quiz_error2_view.dart';
import 'quiz_error_screen.dart';
import 'success_view.dart';

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
    _answerController.addListener(_onAnswerChanged);
  }

  void _onAnswerChanged() {
    context.read<QuizCubit>().updateTextAnswer(_answerController.text);
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
          listenWhen: (prev, curr) => prev.question?.id != curr.question?.id || curr.isFinished,
          listener: (context, state) {
            _answerController.clear();
            if (state.isFinished) {
              context.pushNamedAndRemoveAll(Routes.mainLayout);
            }
          },
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.showSuccess) {
              return QuizSuccessView(
                message: QuizStrings.successMessages[
                  (state.currentQuestionIndex - 1).clamp(
                    0,
                    QuizStrings.successMessages.length - 1,
                  )
                ],
                onContinue: () =>
                    context.read<QuizCubit>().continueToNextQuestion(),
              );
            }

            if (state.errorStage != QuizErrorStage.none) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 450),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                transitionBuilder: (child, animation) {
                  final slide = Tween<Offset>(
                    begin: const Offset(0.08, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(position: slide, child: child),
                  );
                },
                child: state.errorStage == QuizErrorStage.first
                    ? const QuizErrorScreen(key: ValueKey('quiz-error-first'))
                    : QuizError2View(
                        key: const ValueKey('quiz-error-second'),
                        onContinue: () =>
                            context.read<QuizCubit>().continueToNextQuestion(),
                      ),
              );
            }

            final question = state.question;
            if (question == null) return const SizedBox.shrink();

            final hideSpacer = question.type == QuestionType.trueFalse ||
                state.currentQuestionIndex == 3 ||
                state.currentQuestionIndex == 4;

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
                    onBackPressed: () {
                      if (state.currentQuestionIndex == 1) {
                        context.pushReplacement(const QuizInitialView());
                      } else {
                        context.maybePop();
                      }
                    },
                    onPreviousQuestion: () =>
                        context.read<QuizCubit>().previousQuestion(),
                  ),

                  const Spacer(flex: 1),

                  QuizQuestionSection(
                    message: question.title,
                    currentQuestionIndex: state.currentQuestionIndex,
                  ),

                  if (hideSpacer)
                    const SizedBox.shrink()
                  else
                    const Spacer(flex: 1),

                  QuizQuestionBodySection(
                    question: question,
                    state: state,
                    answerController: _answerController,
                  ),

                  const Spacer(flex: 2),

                  QuizActionButton(
                    question: question,
                    state: state,
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
}