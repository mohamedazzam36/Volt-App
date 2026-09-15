import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/core/network/api_endpoints.dart';
import 'package:volt/core/network/api_service.dart';
import 'package:volt/features/lessons/data/models/lesson_detail/lesson_content_model.dart';
import 'package:volt/features/lessons/data/models/lesson_quiz_model.dart';

import '../models/lesson_detail/lesson_detail_model.dart';

abstract class LessonsRemoteDataSource {
  Future<List<LessonContentModel>> getLessonContents({required int id});
  Future<LessonQuizModel> getLessonQuiz({required int lessonId});
  Future<void> postLessonProgress({required int lessonId});
  Future<QuizAttemptModel> startQuizAttempt({required int quizId});
  Future<QuizAttemptResultModel> submitQuizAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  });
}

class LessonsRemoteDataSourceImpl implements LessonsRemoteDataSource {
  LessonsRemoteDataSourceImpl(this._apiService);
  final ApiService _apiService;

  @override
  Future<List<LessonContentModel>> getLessonContents({required int id}) async {
    final result = await _apiService.get(ApiEndpoints.lessonDetails(id));
    final responseModel = LessonDetailModel.fromJson(result);
    return responseModel.contents ?? [];
  }

  @override
  Future<LessonQuizModel> getLessonQuiz({required int lessonId}) async {
    final result = await _apiService.get(ApiEndpoints.quizForLesson(lessonId));
    return LessonQuizModel.fromJson(result);
  }

  @override
  Future<void> postLessonProgress({required int lessonId}) async {
    await _apiService.post(ApiEndpoints.lessonProgress(lessonId));
  }

  @override
  Future<QuizAttemptModel> startQuizAttempt({required int quizId}) async {
    final result = await _apiService.post(ApiEndpoints.startQuizAttempt(quizId));
    return QuizAttemptModel.fromJson(result);
  }

  @override
  Future<QuizAttemptResultModel> submitQuizAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  }) async {
    final result = await _apiService.post(
      ApiEndpoints.submitAttempt(attemptId),
      data: body.toJson(),
    );
    return QuizAttemptResultModel.fromJson(result);
  }
}
