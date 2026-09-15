import 'package:json_annotation/json_annotation.dart';

part 'quiz_attempt_essay_answer_model.g.dart';

@JsonSerializable()
class QuizAttemptEssayAnswerModel {
  final int questionId;
  final String? answerText;

  QuizAttemptEssayAnswerModel({required this.questionId, this.answerText});

  factory QuizAttemptEssayAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAttemptEssayAnswerModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAttemptEssayAnswerModelToJson(this);
}
