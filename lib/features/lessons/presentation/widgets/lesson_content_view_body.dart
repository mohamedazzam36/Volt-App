import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_content_cubit/lesson_content_cubit.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_body_section.dart';

class LessonContentViewBody extends StatelessWidget {
  const LessonContentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: LessonContentBodySection(),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 56,
          ),
        ),
        SliverToBoxAdapter(
          child: CustomElevatedButton(
            width: double.infinity,
            onTap: () {
              context.read<LessonContentCubit>().nextContent();
            },
            text: CommonStrings.next,
          ),
        ),
      ],
    );
  }
}
