import 'package:bloc/bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt/quiz_question_for_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/quiz_attempt_mistake_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/features/placement_quiz/data/models/placement_status_model.dart';
import 'package:volt/features/placement_quiz/data/repos/placement_repo.dart';

part 'placement_quiz_state.dart';

class PlacementQuizCubit extends Cubit<PlacementQuizState> {
  PlacementQuizCubit(this._placementRepo) : super(PlacementQuizInitial());

  final PlacementRepo _placementRepo;

  QuizAttemptModel? _attemptModel;
  int _currentIndex = 0;

  final Map<int, int> _selectedOptions = {};

  List<QuizQuestionForAttemptModel> get _questions =>
      _attemptModel?.questions ?? [];

  int? get attemptId => _attemptModel?.attemptId;

  bool get isLastQuestion =>
      _questions.isNotEmpty && _currentIndex == _questions.length - 1;

  bool get isFirstQuestion => _currentIndex == 0;

  // ─── Check placement status (called before showing intro) ───────────────────

  Future<void> checkPlacementStatus() async {
    emit(PlacementQuizLoading());

    final result = await _placementRepo.getPlacementStatus();

    result.fold(
      (failure) => emit(PlacementQuizError(message: failure.errMessage)),
      (statusModel) => emit(PlacementQuizStatusLoaded(statusModel: statusModel)),
    );
  }

  // ─── Start placement (called from intro screen last step) ───────────────────

  Future<void> startPlacement() async {
    emit(PlacementQuizLoading());

    final result = await _placementRepo.startPlacement();

    result.fold(
      (failure) => emit(PlacementQuizError(message: failure.errMessage)),
      (attempt) {
        _attemptModel = attempt;
        _currentIndex = 0;
        _selectedOptions.clear();
        if (_questions.isNotEmpty) {
          // Signal the intro screen to navigate — emitted only ONCE
          emit(PlacementQuizAttemptStarted());
          _emitCurrentQuestion();
        } else {
          emit(const PlacementQuizError(message: 'لا توجد أسئلة في اختبار التحديد'));
        }
      },
    );
  }

  // ─── Navigation ─────────────────────────────────────────────────────────────

  void nextQuestion() {
    _saveCurrentAnswer();
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      _emitCurrentQuestion();
    }
  }

  void prevQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _emitCurrentQuestion();
    }
  }

  // ─── Answer selection ───────────────────────────────────────────────────────

  void selectAnswer(int optionId) {
    final current = state;
    if (current is PlacementQuizQuestion) {
      emit(current.copyWith(selectedOptionId: optionId, clearOptionId: false));
    }
  }

  // ─── Submit ─────────────────────────────────────────────────────────────────

  Future<void> submitQuiz() async {
    _saveCurrentAnswer();

    final id = attemptId;
    if (id == null) return;

    emit(PlacementQuizSubmitting());

    final mistakes = _selectedOptions.entries
        .map(
          (e) => QuizAttemptMistakeModel(
            questionId: e.key,
            selectedOptionId: e.value,
          ),
        )
        .toList();

    final body = SubmitQuizAttemptModel(
      mistakes: mistakes.isEmpty ? [] : mistakes,
      essayAnswers: [],
    );

    final result = await _placementRepo.submitPlacementAttempt(
      attemptId: id,
      body: body,
    );

    result.fold(
      (failure) => emit(PlacementQuizError(message: failure.errMessage)),
      (resultModel) => emit(PlacementQuizSubmitted(result: resultModel)),
    );
  }

  // ─── Private helpers ────────────────────────────────────────────────────────

  void _saveCurrentAnswer() {
    final current = state;
    if (current is! PlacementQuizQuestion) return;

    final question = current.question;
    final qId = question.questionId;

    switch (question.questionType) {
      case QuestionType.multipleChoice:
      case QuestionType.trueFalse:
        if (current.selectedOptionId != null) {
          _selectedOptions[qId] = current.selectedOptionId!;
        }
      case QuestionType.essay:
      case QuestionType.unknown:
        break;
    }
  }

  void _emitCurrentQuestion() {
    final total = _questions.length;
    final question = _questions[_currentIndex];
    final qId = question.questionId;

    emit(
      PlacementQuizQuestion(
        question: question,
        questionIndex: _currentIndex,
        totalQuestions: total,
        progress: (_currentIndex + 1) / total,
        selectedOptionId: _selectedOptions[qId],
      ),
    );
  }
}
