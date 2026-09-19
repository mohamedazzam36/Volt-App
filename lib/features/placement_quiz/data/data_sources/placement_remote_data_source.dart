import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/core/network/api_endpoints.dart';
import 'package:volt/core/network/api_service.dart';
import 'package:volt/features/placement_quiz/data/models/placement_status_model.dart';

abstract class PlacementRemoteDataSource {
  Future<PlacementStatusModel> getPlacementStatus();
  Future<QuizAttemptModel> startPlacement();
  Future<QuizAttemptResultModel> submitPlacementAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  });
}

class PlacementRemoteDataSourceImpl implements PlacementRemoteDataSource {
  final ApiService _apiService;

  PlacementRemoteDataSourceImpl(this._apiService);

  @override
  Future<PlacementStatusModel> getPlacementStatus() async {
    final result = await _apiService.get(ApiEndpoints.placement);
    return PlacementStatusModel.fromJson(result);
  }

  @override
  Future<QuizAttemptModel> startPlacement() async {
    final result = await _apiService.post(ApiEndpoints.placementStart());
    return QuizAttemptModel.fromJson(result);
  }

  @override
  Future<QuizAttemptResultModel> submitPlacementAttempt({
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
