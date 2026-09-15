// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_essay_answer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptEssayAnswerModel _$QuizAttemptEssayAnswerModelFromJson(
  Map<String, dynamic> json,
) => QuizAttemptEssayAnswerModel(
  questionId: (json['questionId'] as num).toInt(),
  answerText: json['answerText'] as String?,
);

Map<String, dynamic> _$QuizAttemptEssayAnswerModelToJson(
  QuizAttemptEssayAnswerModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'answerText': instance.answerText,
};
