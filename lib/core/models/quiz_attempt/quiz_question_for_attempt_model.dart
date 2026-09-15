import 'package:json_annotation/json_annotation.dart';

import '../../enums/app_enums.dart';
import 'quiz_answer_option_model.dart';

part 'quiz_question_for_attempt_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuizQuestionForAttemptModel {
  final int questionId;
  final String? questionText;

  @JsonKey(unknownEnumValue: QuestionType.unknown)
  final QuestionType questionType;

  final String? imageUrl;

  @JsonKey(unknownEnumValue: QuestionDifficulty.unknown)
  final QuestionDifficulty difficulty;

  final int displayOrder;
  final int points;
  final String? currentHint;
  final List<QuizAnswerOptionModel>? options;

  QuizQuestionForAttemptModel({
    required this.questionId,
    this.questionText,
    required this.questionType,
    this.imageUrl,
    required this.difficulty,
    required this.displayOrder,
    required this.points,
    this.currentHint,
    this.options,
  });

  factory QuizQuestionForAttemptModel.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionForAttemptModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizQuestionForAttemptModelToJson(this);
}
