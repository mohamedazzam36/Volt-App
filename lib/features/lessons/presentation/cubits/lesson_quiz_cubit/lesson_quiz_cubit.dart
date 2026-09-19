import 'package:bloc/bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt/quiz_question_for_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/quiz_attempt_essay_answer_model.dart';
import 'package:volt/core/models/submit_attempt/quiz_attempt_mistake_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/core/network/network_cache_manager.dart';
import 'package:volt/features/lessons/data/repos/lessons_repo.dart';

part 'lesson_quiz_state.dart';

class LessonQuizCubit extends Cubit<LessonQuizState> {
  LessonQuizCubit(this._lessonsRepo, this._cacheManager) : super(LessonQuizInitial());

  final LessonsRepo _lessonsRepo;
  final NetworkCacheManager _cacheManager;

  QuizAttemptModel? _attemptModel;
  int _currentIndex = 0;

  final Map<int, int> _selectedOptions = {};

  final Map<int, String> _essayAnswers = {};

  int? _retryAttemptId;
  List<QuizQuestionForAttemptModel> _retryQuestions = [];
  bool _isRetryMode = false;

  bool get isRetryMode => _isRetryMode;
  int? get attemptId => _isRetryMode ? _retryAttemptId : _attemptModel?.attemptId;
  List<QuizQuestionForAttemptModel> get _questions =>
      _isRetryMode ? _retryQuestions : (_attemptModel?.questions ?? []);

  Future<void> getLessonQuiz({required int lessonId}) async {
    emit(LessonQuizLoading());

    final quizResult = await _lessonsRepo.getLessonQuiz(lessonId: lessonId);

    await quizResult.fold(
      (failure) async => emit(LessonQuizError(message: failure.errMessage)),
      (quizModel) async {
        final attemptResult = await _lessonsRepo.startQuizAttempt(quizId: quizModel.quizId);

        attemptResult.fold(
          (failure) => emit(LessonQuizError(message: failure.errMessage)),
          (attempt) {
            _attemptModel = attempt;
            _currentIndex = 0;
            _selectedOptions.clear();
            _essayAnswers.clear();
            if (_questions.isNotEmpty) {
              _emitCurrentQuestion();
            } else {
              emit(const LessonQuizError(message: 'لا توجد أسئلة في هذا الكويز'));
            }
          },
        );
      },
    );
  }

  void startRetry({
    required List<QuizQuestionForAttemptModel> retryQuestions,
    required int attemptId,
  }) {
    _isRetryMode = true;
    _retryAttemptId = attemptId;
    _retryQuestions = retryQuestions;
    _currentIndex = 0;
    _selectedOptions.clear();
    _essayAnswers.clear();

    if (_retryQuestions.isNotEmpty) {
      _emitCurrentQuestion();
    } else {
      emit(const LessonQuizError(message: 'لا توجد أسئلة للمراجعة'));
    }
  }

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

  bool get isFirstQuestion => _currentIndex == 0;

  void selectAnswer(int optionId) {
    final current = state;
    if (current is LessonQuizQuestion) {
      emit(current.copyWith(selectedOptionId: optionId, clearOptionId: false));
    }
  }

  void updateEssay(String text) {
    final current = state;
    if (current is LessonQuizQuestion) {
      emit(current.copyWith(essayText: text));
    }
  }

  Future<void> submitQuiz() async {
    _saveCurrentAnswer();

    final id = attemptId;
    if (id == null) return;

    emit(LessonQuizSubmitting());

    final mistakes = _selectedOptions.entries
        .map(
          (e) => QuizAttemptMistakeModel(
            questionId: e.key,
            selectedOptionId: e.value,
          ),
        )
        .toList();

    final essayAnswers = _essayAnswers.entries
        .map(
          (e) => QuizAttemptEssayAnswerModel(
            questionId: e.key,
            answerText: e.value,
          ),
        )
        .toList();

    final body = SubmitQuizAttemptModel(
      mistakes: mistakes.isEmpty ? [] : mistakes,
      essayAnswers: essayAnswers.isEmpty ? [] : essayAnswers,
    );

    final result = await _lessonsRepo.submitQuizAttempt(
      attemptId: id,
      body: body,
    );

    result.fold(
      (failure) => emit(LessonQuizError(message: failure.errMessage)),
      (resultModel) async {
        await _cacheManager.clearHomeCache();
        emit(LessonQuizSubmitted(result: resultModel));
      },
    );
  }

  void _saveCurrentAnswer() {
    final current = state;
    if (current is! LessonQuizQuestion) return;

    final question = current.question;
    final qId = question.questionId;

    switch (question.questionType) {
      case QuestionType.multipleChoice:
      case QuestionType.trueFalse:
        if (current.selectedOptionId != null) {
          _selectedOptions[qId] = current.selectedOptionId!;
        }

      case QuestionType.essay:
        if (current.essayText.isNotEmpty) {
          _essayAnswers[qId] = current.essayText;
        }

      case QuestionType.unknown:
        break;
    }
  }

  void _emitCurrentQuestion() {
    final total = _questions.length;
    final question = _questions[_currentIndex];
    final qId = question.questionId;

    emit(
      LessonQuizQuestion(
        question: question,
        questionIndex: _currentIndex,
        totalQuestions: total,
        progress: (_currentIndex + 1) / total,
        selectedOptionId: _selectedOptions[qId],
        essayText: _essayAnswers[qId] ?? '',
      ),
    );
  }

  bool get isLastQuestion => _questions.isNotEmpty && _currentIndex == _questions.length - 1;
}
