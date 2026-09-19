import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:volt/core/errors/api_failures.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/features/placement_quiz/data/data_sources/placement_remote_data_source.dart';
import 'package:volt/features/placement_quiz/data/models/placement_status_model.dart';
import 'package:volt/features/placement_quiz/data/repos/placement_repo.dart';

class PlacementRepoImpl implements PlacementRepo {
  final PlacementRemoteDataSource _remoteDataSource;

  PlacementRepoImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, PlacementStatusModel>> getPlacementStatus() async {
    try {
      final result = await _remoteDataSource.getPlacementStatus();
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizAttemptModel>> startPlacement() async {
    try {
      final result = await _remoteDataSource.startPlacement();
      return right(result);
    } on DioException catch (e) {
      return left(ApiFailure.fromDioException(e));
    } catch (e) {
      return left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, QuizAttemptResultModel>> submitPlacementAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  }) async {
    try {
      final result = await _remoteDataSource.submitPlacementAttempt(
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
