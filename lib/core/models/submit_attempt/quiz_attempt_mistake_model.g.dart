// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_mistake_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptMistakeModel _$QuizAttemptMistakeModelFromJson(
  Map<String, dynamic> json,
) => QuizAttemptMistakeModel(
  questionId: (json['questionId'] as num).toInt(),
  selectedOptionId: (json['selectedOptionId'] as num).toInt(),
);

Map<String, dynamic> _$QuizAttemptMistakeModelToJson(
  QuizAttemptMistakeModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'selectedOptionId': instance.selectedOptionId,
};
