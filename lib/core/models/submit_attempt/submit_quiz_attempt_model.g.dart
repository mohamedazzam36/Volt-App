// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_quiz_attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitQuizAttemptModel _$SubmitQuizAttemptModelFromJson(
  Map<String, dynamic> json,
) => SubmitQuizAttemptModel(
  mistakes: (json['mistakes'] as List<dynamic>?)
      ?.map((e) => QuizAttemptMistakeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  essayAnswers: (json['essayAnswers'] as List<dynamic>?)
      ?.map(
        (e) => QuizAttemptEssayAnswerModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$SubmitQuizAttemptModelToJson(
  SubmitQuizAttemptModel instance,
) => <String, dynamic>{
  'mistakes': instance.mistakes?.map((e) => e.toJson()).toList(),
  'essayAnswers': instance.essayAnswers?.map((e) => e.toJson()).toList(),
};
