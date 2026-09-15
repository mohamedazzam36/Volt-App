import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:volt/core/errors/api_failures.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/features/lessons/data/data_sources/lessons_remote_data_source.dart';
import 'package:volt/features/lessons/data/models/lesson_detail/lesson_content_model.dart';
import 'package:volt/features/lessons/data/models/lesson_quiz_model.dart';
import 'package:volt/features/lessons/data/repos/lessons_repo.dart';

class LessonsRepoImpl implements LessonsRepo {
  final LessonsRemoteDataSource _lessonsRemoteDataSource;

  LessonsRepoImpl(this._lessonsRemoteDataSource);

  @override
  Future<Either<Failure, List<LessonContentModel>>> getLessonContents({required int id}) async {
    try {
      final result = await _lessonsRemoteDataSource.getLessonContents(id: id);
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LessonQuizModel>> getLessonQuiz({required int lessonId}) async {
    try {
      final result = await _lessonsRemoteDataSource.getLessonQuiz(lessonId: lessonId);
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> postLessonProgress({required int lessonId}) async {
    try {
      await _lessonsRemoteDataSource.postLessonProgress(lessonId: lessonId);
      return right(null);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizAttemptModel>> startQuizAttempt({required int quizId}) async {
    try {
      final result = await _lessonsRemoteDataSource.startQuizAttempt(quizId: quizId);
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizAttemptResultModel>> submitQuizAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  }) async {
    try {
      final result = await _lessonsRemoteDataSource.submitQuizAttempt(
        attemptId: attemptId,
        body: body,
      );
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }
}
