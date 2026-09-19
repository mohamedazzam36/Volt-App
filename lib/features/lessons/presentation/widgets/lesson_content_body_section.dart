import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/features/lessons/presentation/cubits/lesson_content_cubit/lesson_content_cubit.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_bodies/image_content_body.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_bodies/text_and_image_content_body.dart';
import 'package:volt/features/lessons/presentation/widgets/lesson_content_bodies/text_content_body.dart';

class LessonContentBodySection extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonContentCubit, LessonContentState>(
      builder: (context, state) => switch (state) {
        LessonNextContent() => switch (state.contentTypeName) {
          LessonContentType.text => TextContentBody(
            content: state.content,
            isFirst: context.read<LessonContentCubit>().currentContentIndex == 0,
          ),
          LessonContentType.image => ImageContentBody(mediaUrl: state.mediaUrl),
          LessonContentType.textAndImage => TextAndImageContentBody(
            content: state.content,
            mediaUrl: state.mediaUrl,
            isFirst: context.read<LessonContentCubit>().currentContentIndex == 0,
          ),
          LessonContentType.unknown => const Center(child: Text('Unknown content type')),
        },
        LessonContentError() => Center(child: Text(state.message)),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
