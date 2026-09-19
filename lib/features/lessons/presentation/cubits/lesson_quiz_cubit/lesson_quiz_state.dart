part of 'lesson_quiz_cubit.dart';

sealed class LessonQuizState {
  const LessonQuizState();
}

final class LessonQuizInitial extends LessonQuizState {}

final class LessonQuizLoading extends LessonQuizState {}

final class LessonQuizSubmitting extends LessonQuizState {}

final class LessonQuizError extends LessonQuizState {
  final String message;
  const LessonQuizError({required this.message});
}

final class LessonQuizQuestion extends LessonQuizState {
  final QuizQuestionForAttemptModel question;
  final int questionIndex;
  final int totalQuestions;
  final double progress;

  final int? selectedOptionId;
  final String essayText;

  /// true while waiting for the hint API response
  final bool isHintLoading;

  /// non-null when a hint has arrived and hasn't been shown yet
  final HintResponseModel? pendingHint;

  const LessonQuizQuestion({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.progress,
    this.selectedOptionId,
    this.essayText = '',
    this.isHintLoading = false,
    this.pendingHint,
  });

  LessonQuizQuestion copyWith({
    QuizQuestionForAttemptModel? question,
    int? questionIndex,
    int? totalQuestions,
    double? progress,
    int? selectedOptionId,
    String? essayText,
    bool clearOptionId = false,
    bool? isHintLoading,
    HintResponseModel? pendingHint,
    bool clearPendingHint = false,
  }) {
    return LessonQuizQuestion(
      question: question ?? this.question,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      progress: progress ?? this.progress,
      selectedOptionId: clearOptionId ? null : (selectedOptionId ?? this.selectedOptionId),
      essayText: essayText ?? this.essayText,
      isHintLoading: isHintLoading ?? this.isHintLoading,
      pendingHint: clearPendingHint ? null : (pendingHint ?? this.pendingHint),
    );
  }
}

final class LessonQuizSubmitted extends LessonQuizState {
  final QuizAttemptResultModel result;
  const LessonQuizSubmitted({required this.result});
}
