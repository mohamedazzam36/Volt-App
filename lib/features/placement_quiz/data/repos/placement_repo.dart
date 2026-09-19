import 'package:dartz/dartz.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/quiz_attempt/quiz_attempt_model.dart';
import 'package:volt/core/models/quiz_attempt_result/quiz_attempt_result_model.dart';
import 'package:volt/core/models/submit_attempt/submit_quiz_attempt_model.dart';
import 'package:volt/features/placement_quiz/data/models/placement_status_model.dart';

abstract class PlacementRepo {
  Future<Either<Failure, PlacementStatusModel>> getPlacementStatus();
  Future<Either<Failure, QuizAttemptModel>> startPlacement();
  Future<Either<Failure, QuizAttemptResultModel>> submitPlacementAttempt({
    required int attemptId,
    required SubmitQuizAttemptModel body,
  });
}
