// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptModel _$QuizAttemptModelFromJson(Map<String, dynamic> json) =>
    QuizAttemptModel(
      attemptId: (json['attemptId'] as num).toInt(),
      quizId: (json['quizId'] as num).toInt(),
      startedAt: DateTime.parse(json['startedAt'] as String),
      language: json['language'] as String?,
      languageFallbackApplied: json['languageFallbackApplied'] as bool,
      questions: (json['questions'] as List<dynamic>?)
          ?.map(
            (e) =>
                QuizQuestionForAttemptModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$QuizAttemptModelToJson(QuizAttemptModel instance) =>
    <String, dynamic>{
      'attemptId': instance.attemptId,
      'quizId': instance.quizId,
      'startedAt': instance.startedAt.toIso8601String(),
      'language': instance.language,
      'languageFallbackApplied': instance.languageFallbackApplied,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };
