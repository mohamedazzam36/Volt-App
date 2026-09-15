import 'package:json_annotation/json_annotation.dart';

import '../../../../core/models/quiz_attempt/quiz_question_for_attempt_model.dart';

part 'lesson_quiz_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonQuizModel {
  final int quizId;
  final int lessonId;
  final String? title;
  final String? description;
  final int totalQuestions;
  final String? language;
  final bool languageFallbackApplied;
  final List<QuizQuestionForAttemptModel>? questions;

  LessonQuizModel({
    required this.quizId,
    required this.lessonId,
    this.title,
    this.description,
    required this.totalQuestions,
    this.language,
    required this.languageFallbackApplied,
    this.questions,
  });

  factory LessonQuizModel.fromJson(Map<String, dynamic> json) => _$LessonQuizModelFromJson(json);
  Map<String, dynamic> toJson() => _$LessonQuizModelToJson(this);
}
