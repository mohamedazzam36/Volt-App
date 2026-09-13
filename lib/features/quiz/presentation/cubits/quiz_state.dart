import 'package:equatable/equatable.dart';
import '../../data/models/question_model.dart';

enum QuizErrorStage { none, first, second }

class QuizState extends Equatable {
  final bool isLoading;
  final QuestionModel? question;
  final String? selectedOptionId;
  final bool? selectedBoolValue;
  final String? textAnswer;
  final bool showSuccess;
  final QuizErrorStage errorStage;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int lives;

  const QuizState({
    this.isLoading = false,
    this.question,
    this.selectedOptionId,
    this.selectedBoolValue,
    this.textAnswer,
    this.showSuccess = false,
    this.errorStage = QuizErrorStage.none,
    this.currentQuestionIndex = 1,
    this.totalQuestions = 6,
    this.lives = 5,
  });

  bool get isButtonEnabled {
    if (question == null) return false;
    switch (question!.type) {
      case QuestionType.mcq:
      case QuestionType.imageChoice:
      case QuestionType.wordChips:
        return selectedOptionId != null;
      case QuestionType.trueFalse:
        return selectedBoolValue != null;
      case QuestionType.fillInBlank:
        return textAnswer != null && textAnswer!.trim().isNotEmpty;
    }
  }

  QuizState copyWith({
    bool? isLoading,
    QuestionModel? question,
    String? selectedOptionId,
    bool? selectedBoolValue,
    String? textAnswer,
    bool? showSuccess,
    QuizErrorStage? errorStage,
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
      errorStage: errorStage ?? this.errorStage,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      lives: lives ?? this.lives,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        question,
        selectedOptionId,
        selectedBoolValue,
        textAnswer,
        showSuccess,
        errorStage,
        currentQuestionIndex,
        totalQuestions,
        lives,
      ];
}
