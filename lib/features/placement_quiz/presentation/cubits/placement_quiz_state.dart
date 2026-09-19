part of 'placement_quiz_cubit.dart';

sealed class PlacementQuizState {
  const PlacementQuizState();
}

final class PlacementQuizInitial extends PlacementQuizState {}

final class PlacementQuizLoading extends PlacementQuizState {}

final class PlacementQuizSubmitting extends PlacementQuizState {}

final class PlacementQuizError extends PlacementQuizState {
  final String message;
  const PlacementQuizError({required this.message});
}

/// Emitted after GET /api/placement – used to decide navigation
final class PlacementQuizStatusLoaded extends PlacementQuizState {
  final PlacementStatusModel statusModel;
  const PlacementQuizStatusLoaded({required this.statusModel});
}

/// Emitted ONCE when the attempt is successfully started – triggers navigation from intro to quiz screen
final class PlacementQuizAttemptStarted extends PlacementQuizState {}

final class PlacementQuizQuestion extends PlacementQuizState {
  final QuizQuestionForAttemptModel question;
  final int questionIndex;
  final int totalQuestions;
  final double progress;
  final int? selectedOptionId;

  const PlacementQuizQuestion({
    required this.question,
    required this.questionIndex,
    required this.totalQuestions,
    required this.progress,
    this.selectedOptionId,
  });

  PlacementQuizQuestion copyWith({
    QuizQuestionForAttemptModel? question,
    int? questionIndex,
    int? totalQuestions,
    double? progress,
    int? selectedOptionId,
    bool clearOptionId = false,
  }) {
    return PlacementQuizQuestion(
      question: question ?? this.question,
      questionIndex: questionIndex ?? this.questionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      progress: progress ?? this.progress,
      selectedOptionId:
          clearOptionId ? null : (selectedOptionId ?? this.selectedOptionId),
    );
  }
}

final class PlacementQuizSubmitted extends PlacementQuizState {
  final QuizAttemptResultModel result;
  const PlacementQuizSubmitted({required this.result});
}
