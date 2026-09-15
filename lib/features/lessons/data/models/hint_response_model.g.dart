// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hint_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HintResponseModel _$HintResponseModelFromJson(Map<String, dynamic> json) =>
    HintResponseModel(
      questionId: (json['questionId'] as num).toInt(),
      attemptNumber: (json['attemptNumber'] as num).toInt(),
      hint: json['hint'] as String?,
      hintsStatus: $enumDecode(
        _$HintsStatusEnumMap,
        json['hintsStatus'],
        unknownValue: HintsStatus.unknown,
      ),
      hintsRemaining: (json['hintsRemaining'] as num).toInt(),
      language: json['language'] as String?,
    );

Map<String, dynamic> _$HintResponseModelToJson(HintResponseModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'attemptNumber': instance.attemptNumber,
      'hint': instance.hint,
      'hintsStatus': _$HintsStatusEnumMap[instance.hintsStatus]!,
      'hintsRemaining': instance.hintsRemaining,
      'language': instance.language,
    };

const _$HintsStatusEnumMap = {
  HintsStatus.notRequired: 'NotRequired',
  HintsStatus.generated: 'Generated',
  HintsStatus.partial: 'Partial',
  HintsStatus.unavailable: 'Unavailable',
  HintsStatus.unknown: 'unknown',
};
