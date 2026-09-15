import 'package:dartz/dartz.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/features/lessons/data/models/lesson_detail/lesson_content_model.dart';
import 'package:volt/features/lessons/data/models/lesson_quiz_model.dart';

abstract class LessonsRepo {
  Future<Either<Failure, List<LessonContentModel>>> getLessonContents({required int id});
  Future<Either<Failure, LessonQuizModel>> getLessonQuiz({required int lessonId});
  Future<Either<Failure, void>> postLessonProgress({required int lessonId});
  Future<Either<Failure, QuizAttemptModel>> startQuizAttempt({required int quizId});
  Future<Either<Failure, QuizAttemptResultModel>> submitQuizAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  });
}
