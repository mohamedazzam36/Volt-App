import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_quiz_cubit/lesson_quiz_cubit.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_quiz/quiz_question_body.dart';

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
        LessonQuizQuestion() => QuizQuestionBody(state: state),
        _ => const Center(
          child: CircularProgressIndicator(),
        ),
      },
    );
  }
}
