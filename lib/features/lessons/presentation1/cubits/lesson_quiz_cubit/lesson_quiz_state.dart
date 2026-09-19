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

  const LessonQuizQuestion({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.progress,
    this.selectedOptionId,
    this.essayText = '',
  });

  LessonQuizQuestion copyWith({
    QuizQuestionForAttemptModel? question,
    int? questionIndex,
    int? totalQuestions,
    double? progress,
    int? selectedOptionId,
    String? essayText,
    bool clearOptionId = false,
  }) {
    return LessonQuizQuestion(
      question: question ?? this.question,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      progress: progress ?? this.progress,
      selectedOptionId: clearOptionId ? null : (selectedOptionId ?? this.selectedOptionId),
      essayText: essayText ?? this.essayText,
    );
  }
}

final class LessonQuizSubmitted extends LessonQuizState {
  final QuizAttemptResultModel result;
  const LessonQuizSubmitted({required this.result});
}
