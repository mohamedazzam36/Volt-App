// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_answer_option_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAnswerOptionModel _$QuizAnswerOptionModelFromJson(
  Map<String, dynamic> json,
) => QuizAnswerOptionModel(
  optionId: (json['optionId'] as num).toInt(),
  optionText: json['optionText'] as String?,
  imageUrl: json['imageUrl'] as String?,
  displayOrder: (json['displayOrder'] as num).toInt(),
);

Map<String, dynamic> _$QuizAnswerOptionModelToJson(
  QuizAnswerOptionModel instance,
) => <String, dynamic>{
  'optionId': instance.optionId,
  'optionText': instance.optionText,
  'imageUrl': instance.imageUrl,
  'displayOrder': instance.displayOrder,
};
