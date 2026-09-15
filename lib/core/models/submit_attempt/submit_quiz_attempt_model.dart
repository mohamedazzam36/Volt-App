import 'package:json_annotation/json_annotation.dart';

import 'quiz_attempt_mistake_model.dart';
import 'quiz_attempt_essay_answer_model.dart';

part 'submit_quiz_attempt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubmitQuizAttemptModel {
  final List<QuizAttemptMistakeModel>? mistakes;
  final List<QuizAttemptEssayAnswerModel>? essayAnswers;

  SubmitQuizAttemptModel({this.mistakes, this.essayAnswers});

  factory SubmitQuizAttemptModel.fromJson(Map<String, dynamic> json) =>
      _$SubmitQuizAttemptModelFromJson(json);
  Map<String, dynamic> toJson() => _$SubmitQuizAttemptModelToJson(this);
}
