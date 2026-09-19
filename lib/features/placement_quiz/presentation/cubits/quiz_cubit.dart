import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/features/placement_quiz/data/models/question_model.dart';
import 'package:volt/features/placement_quiz/data/repositories/quiz_repository.dart';
import 'package:volt/features/placement_quiz/presentation/cubits/quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository repository;

  List<QuestionModel> _questions = [];

  QuizCubit(this.repository) : super(const QuizState());

  Future<void> loadQuestions() async {
    emit(state.copyWith(isLoading: true));

    try {
      _questions = await repository.getQuestions();

      if (_questions.isEmpty) {
        emit(state.copyWith(isLoading: false));

        return;
      }

      emit(
        QuizState(
          isLoading: false,

          question: _questions.first,

          currentQuestionIndex: 1,

          totalQuestions: _questions.length,

          lives: state.lives,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> loadQuestion(String questionId) async {
    emit(state.copyWith(isLoading: true));

    try {
      final question = await repository.getQuestionById(questionId);

      emit(
        state.copyWith(
          isLoading: false,

          question: question,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void selectOption(String optionId) {
    emit(
      state.copyWith(
        question: state.question,

        selectedOptionId: optionId,
      ),
    );
  }

  void selectBool(bool val) {
    emit(
      state.copyWith(
        question: state.question,

        selectedBoolValue: val,
      ),
    );
  }

  void updateTextAnswer(String text) {
    emit(
      state.copyWith(
        question: state.question,

        textAnswer: text,
      ),
    );
  }

  bool _isCorrectAnswer() {
    if (state.question == null) return false;

    switch (state.question!.type) {
      case QuestionType.mcq:
      case QuestionType.imageChoice:
      case QuestionType.wordChips:
        return state.selectedOptionId == state.question!.correctAnswer;

      case QuestionType.trueFalse:
        return state.selectedBoolValue == state.question!.correctAnswer;

      case QuestionType.fillInBlank:
        return state.textAnswer?.trim().toLowerCase() ==
            (state.question!.correctAnswer as String? ?? '').trim().toLowerCase();
    }
  }

  void submitAnswer() {
    if (!state.isButtonEnabled) return;

    if (_isCorrectAnswer()) {
      emit(state.copyWith(showSuccess: true));

      return;
    }

    emit(
      state.copyWith(
        errorStage: QuizErrorStage.first,

        lives: (state.lives - 1).clamp(0, state.lives),
      ),
    );

    _showSecondError();
  }

  void continueToNextQuestion() {
    if (!state.showSuccess && state.errorStage != QuizErrorStage.second) return;

    final nextQuestionIndex = state.currentQuestionIndex;

    if (nextQuestionIndex >= _questions.length) {
      emit(state.copyWith(isFinished: true, showSuccess: false, errorStage: QuizErrorStage.none));
      return;
    }

    emit(
      QuizState(
        question: _questions[nextQuestionIndex],
        currentQuestionIndex: nextQuestionIndex + 1,
        totalQuestions: _questions.length,
        lives: state.lives,
      ),
    );
  }

  Future<void> _showSecondError() async {
    await Future<void>.delayed(const Duration(seconds: 2));

    if (isClosed || state.errorStage != QuizErrorStage.first) return;

    emit(state.copyWith(errorStage: QuizErrorStage.second));
  }

  void previousQuestion() {
    if (state.currentQuestionIndex <= 1) return;

    final previousQuestionIndex = state.currentQuestionIndex - 2;

    if (previousQuestionIndex < 0 || previousQuestionIndex >= _questions.length) return;

    emit(
      QuizState(
        question: _questions[previousQuestionIndex],
        currentQuestionIndex: previousQuestionIndex + 1,
        totalQuestions: _questions.length,
        lives: state.lives,
        selectedOptionId: null,
        selectedBoolValue: null,
        textAnswer: null,
      ),
    );
  }
}
