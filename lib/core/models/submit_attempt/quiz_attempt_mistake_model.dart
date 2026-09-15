import 'package:json_annotation/json_annotation.dart';

part 'quiz_attempt_mistake_model.g.dart';

@JsonSerializable()
class QuizAttemptMistakeModel {
  final int questionId;
  final int selectedOptionId;

  QuizAttemptMistakeModel({required this.questionId, required this.selectedOptionId});

  factory QuizAttemptMistakeModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptMistakeModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptMistakeModelToJson(this);
}
