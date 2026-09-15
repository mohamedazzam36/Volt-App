import 'package:json_annotation/json_annotation.dart';

part 'quiz_answer_option_model.g.dart';

@JsonSerializable()
class QuizAnswerOptionModel {
  final int optionId;
  final String? optionText;
  final String? imageUrl;
  final int displayOrder;

  QuizAnswerOptionModel({
    required this.optionId,
    this.optionText,
    this.imageUrl,
    required this.displayOrder,
  });

  factory QuizAnswerOptionModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerOptionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuizAnswerOptionModelToJson(this);
}
