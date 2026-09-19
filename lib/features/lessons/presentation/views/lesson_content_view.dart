import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/snack_bar_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_content_cubit/lesson_content_cubit.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_app_bar.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_view_body.dart';

class LessonContentView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LessonContentCubit, LessonContentState>(
      listener: (context, state) {
        if (state is LessonContentError) {
          context.showSnackBar(state.message, type: SnackBarType.error);
        } else if (state is LessonContentDone) {
          context.pushReplacementNamed(
            Routes.lessonQuiz,
            arguments: state.lessonId,
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
          appBar: LessonContentAppBar(
            onBackTap: () {
              if (context.read<LessonContentCubit>().currentContentIndex == 0) {
                context.pop();
              } else {
                context.read<LessonContentCubit>().prevContent();
              }
            },
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: LessonContentViewBody(),
          ),
        ),
      ),
    );
  }
}
