import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/app_enums.dart';

part 'hint_response_model.g.dart';

@JsonSerializable()
class HintResponseModel {
  final int questionId;
  final int attemptNumber;
  final String? hint;

  @JsonKey(unknownEnumValue: HintsStatus.unknown)
  final HintsStatus hintsStatus;

  final int hintsRemaining;
  final String? language;

  HintResponseModel({
    required this.questionId,
    required this.attemptNumber,
    this.hint,
    required this.hintsStatus,
    required this.hintsRemaining,
    this.language,
  });

  factory HintResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HintResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$HintResponseModelToJson(this);
}
