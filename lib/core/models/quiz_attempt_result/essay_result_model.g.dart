// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'essay_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EssayResultModel _$EssayResultModelFromJson(Map<String, dynamic> json) =>
    EssayResultModel(
      questionId: (json['questionId'] as num).toInt(),
      status: $enumDecode(
        _$EssayAnswerStatusEnumMap,
        json['status'],
        unknownValue: EssayAnswerStatus.unknown,
      ),
      awardedPoints: (json['awardedPoints'] as num?)?.toInt(),
      maxPoints: (json['maxPoints'] as num).toInt(),
      feedback: json['feedback'] as String?,
    );

Map<String, dynamic> _$EssayResultModelToJson(EssayResultModel instance) =>
    <String, dynamic>{
      'questionId': instance.questionId,
      'status': _$EssayAnswerStatusEnumMap[instance.status]!,
      'awardedPoints': instance.awardedPoints,
      'maxPoints': instance.maxPoints,
      'feedback': instance.feedback,
    };

const _$EssayAnswerStatusEnumMap = {
  EssayAnswerStatus.pending: 'Pending',
  EssayAnswerStatus.graded: 'Graded',
  EssayAnswerStatus.notGraded: 'NotGraded',
  EssayAnswerStatus.unknown: 'unknown',
};
