import '../../data/models/question_model.dart';

class QuizState {
  final bool isLoading;
  final QuestionModel? question;
  final String? selectedOptionId;
  final bool? selectedBoolValue;
  final String? textAnswer;
  final bool showSuccess;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int lives;

  QuizState({
    this.isLoading = false,
    this.question,
    this.selectedOptionId,
    this.selectedBoolValue,
    this.textAnswer,
    this.showSuccess = false,
    this.currentQuestionIndex = 1,
    this.totalQuestions = 6,
    this.lives = 5,
  });

  /// خاصية للتحقق مما إذا كان زر الإرسال مفاعلاً أم مغلقاً
  bool get isButtonEnabled {
    if (question == null) return false;
    switch (question!.type) {
      case QuestionType.mcq:
      case QuestionType.imageChoice:
        return selectedOptionId != null;
      case QuestionType.trueFalse:
        return selectedBoolValue != null;
      case QuestionType.fillInBlank:
        return textAnswer != null && textAnswer!.trim().isNotEmpty;
      case QuestionType.wordChips:
        return selectedOptionId != null;
    }
  }

  QuizState copyWith({
    bool? isLoading,
    QuestionModel? question,
    String? selectedOptionId,
    bool? selectedBoolValue,
    String? textAnswer,
    bool? showSuccess,
    int? currentQuestionIndex,
    int? totalQuestions,
    int? lives,
  }) {
    return QuizState(
      isLoading: isLoading ?? this.isLoading,
      question: question ?? this.question,
      selectedOptionId: selectedOptionId ?? this.selectedOptionId,
      selectedBoolValue: selectedBoolValue ?? this.selectedBoolValue,
      textAnswer: textAnswer ?? this.textAnswer,
      showSuccess: showSuccess ?? this.showSuccess,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      lives: lives ?? this.lives,
    );
  }
}
