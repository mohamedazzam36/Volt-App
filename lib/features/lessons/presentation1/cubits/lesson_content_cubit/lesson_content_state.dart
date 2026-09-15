part of 'lesson_content_cubit.dart';

sealed class LessonContentState {
  const LessonContentState();
}

final class LessonContentInitial extends LessonContentState {}

final class LessonNextContent extends LessonContentState {
  final double progress;
  final LessonContentType contentTypeName;
  final String? content;
  final String? mediaUrl;

  const LessonNextContent({
    required this.progress,
    required this.contentTypeName,
    this.content,
    this.mediaUrl,
  });
}

final class LessonContentError extends LessonContentState {
  final String message;
  const LessonContentError({required this.message});
}

final class LessonContentLoading extends LessonContentState {}

final class LessonContentDone extends LessonContentState {
  final int lessonId;
  const LessonContentDone({required this.lessonId});
}
