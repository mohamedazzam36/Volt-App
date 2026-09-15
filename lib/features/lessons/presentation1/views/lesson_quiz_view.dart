import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/lessons/presentation1/cubits/lesson_content_cubit/lesson_quiz_cubit/lesson_quiz_cubit.dart';
import 'package:volt/features/lessons/presentation1/widgets/lesson_quiz_app_bar.dart';
import 'package:volt/features/lessons/presentation1/widgets/lesson_quiz_view_body.dart';

class LessonQuizView extends StatelessWidget {
  const LessonQuizView({super.key, this.retryAttemptNumber = 0});

  final int retryAttemptNumber;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonQuizCubit, LessonQuizState>(
      listener: (context, state) {
        if (state is LessonQuizError) {
          context.showSnackBar(state.message, type: SnackBarType.error);
        } else if (state is LessonQuizSubmitted) {
          Navigator.of(context).pushReplacementNamed(
            Routes.lessonQuizResult,
            arguments: LessonQuizResultArgs(
              result: state.result,
              retryAttemptNumber: retryAttemptNumber,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.lessonsBackgroundImage1.path),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: LessonQuizAppBar(
            onCloseTap: () {
              final cubit = context.read<LessonQuizCubit>();
              if (cubit.isFirstQuestion) {
                Navigator.of(context).maybePop();
              } else {
                cubit.prevQuestion();
              }
            },
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LessonQuizViewBody(),
          ),
        ),
      ),
    );
  }
}

class LessonQuizResultArgs {
  final dynamic result;
  final int retryAttemptNumber;

  const LessonQuizResultArgs({
    required this.result,
    required this.retryAttemptNumber,
  });
}
