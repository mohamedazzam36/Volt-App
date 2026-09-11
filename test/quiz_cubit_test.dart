import 'package:flutter_test/flutter_test.dart';
import 'package:volt/features/quiz/data/repositories/quiz_repository.dart';
import 'package:volt/features/quiz/presentation/cubits/quiz_cubit.dart';

void main() {
  test('previousQuestion returns to the previous question', () async {
    final cubit = QuizCubit(QuizRepository());

    await cubit.loadQuestions();
    expect(cubit.state.currentQuestionIndex, 1);
    expect(cubit.state.question?.id, '1');

    cubit.updateTextAnswer('كولوم');
    cubit.submitAnswer();

    expect(cubit.state.showSuccess, isTrue);

    cubit.continueToNextQuestion();

    expect(cubit.state.currentQuestionIndex, 2);
    expect(cubit.state.question?.id, '2');
    expect(cubit.state.showSuccess, isFalse);

    cubit.previousQuestion();

    expect(cubit.state.currentQuestionIndex, 1);
    expect(cubit.state.question?.id, '1');
  });
}
