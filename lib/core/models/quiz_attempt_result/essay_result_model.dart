import 'package:json_annotation/json_annotation.dart';

import '../../enums/app_enums.dart';

part 'essay_result_model.g.dart';

@JsonSerializable()
class EssayResultModel {
  final int questionId;
  @JsonKey(unknownEnumValue: EssayAnswerStatus.unknown)
  final EssayAnswerStatus status;
  final int? awardedPoints;
  final int maxPoints;
  final String? feedback;

  EssayResultModel({
    required this.questionId,
    required this.status,
    this.awardedPoints,
    required this.maxPoints,
    this.feedback,
  });

  factory EssayResultModel.fromJson(Map<String, dynamic> json) => _$EssayResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$EssayResultModelToJson(this);
}
