import 'package:json_annotation/json_annotation.dart';

import '../../enums/app_enums.dart';
import '../quiz_attempt/quiz_question_for_attempt_model.dart';
import 'essay_result_model.dart';

part 'quiz_attempt_result_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizAttemptResultModel {
  final int attemptId;
  final int quizId;
  final DateTime? completedAt;
  final int totalQuestions;
  final int autoGradedQuestions;
  final int pendingEssayQuestions;
  final List<EssayResultModel>? essayResults;
  final int correctAnswers;
  final int wrongAnswers;
  final double scorePercentage;
  final int totalPoints;
  final int earnedPoints;
  final int pendingPoints;
  final String? language;
  final bool languageFallbackApplied;

  @JsonKey(unknownEnumValue: HintsStatus.unknown)
  final HintsStatus hintsStatus;

  final List<QuizQuestionForAttemptModel>? retryQuestions;

  QuizAttemptResultModel({
    required this.attemptId,
    required this.quizId,
    this.completedAt,
    required this.totalQuestions,
    required this.autoGradedQuestions,
    required this.pendingEssayQuestions,
    this.essayResults,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.scorePercentage,
    required this.totalPoints,
    required this.earnedPoints,
    required this.pendingPoints,
    this.language,
    required this.languageFallbackApplied,
    required this.hintsStatus,
    this.retryQuestions,
  });

  factory QuizAttemptResultModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptResultModelToJson(this);
}
