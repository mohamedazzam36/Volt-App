// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_quiz_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonQuizModel _$LessonQuizModelFromJson(Map<String, dynamic> json) =>
    LessonQuizModel(
      quizId: (json['quizId'] as num).toInt(),
      lessonId: (json['lessonId'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      language: json['language'] as String?,
      languageFallbackApplied: json['languageFallbackApplied'] as bool,
      questions: (json['questions'] as List<dynamic>?)
          ?.map(
            (e) =>
                QuizQuestionForAttemptModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$LessonQuizModelToJson(LessonQuizModel instance) =>
    <String, dynamic>{
      'quizId': instance.quizId,
      'lessonId': instance.lessonId,
      'title': instance.title,
      'description': instance.description,
      'totalQuestions': instance.totalQuestions,
      'language': instance.language,
      'languageFallbackApplied': instance.languageFallbackApplied,
      'questions': instance.questions?.map((e) => e.toJson()).toList(),
    };
