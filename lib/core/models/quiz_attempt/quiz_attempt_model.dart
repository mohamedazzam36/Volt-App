import 'package:json_annotation/json_annotation.dart';

import 'quiz_question_for_attempt_model.dart';

part 'quiz_attempt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizAttemptModel {
  final int attemptId;
  final int quizId;
  final DateTime startedAt;
  final String? language;
  final bool languageFallbackApplied;
  final List<QuizQuestionForAttemptModel>? questions;

  QuizAttemptModel({
    required this.attemptId,
    required this.quizId,
    required this.startedAt,
    this.language,
    required this.languageFallbackApplied,
    this.questions,
  });

  factory QuizAttemptModel.fromJson(Map<String, dynamic> json) => _$QuizAttemptModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptModelToJson(this);
}
