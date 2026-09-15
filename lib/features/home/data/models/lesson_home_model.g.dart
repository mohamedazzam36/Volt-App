// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonHomeModel _$LessonHomeModelFromJson(Map<String, dynamic> json) =>
    LessonHomeModel(
      lessonId: (json['lessonId'] as num).toInt(),
      levelName: json['levelName'] as String?,
      lessonName: json['lessonName'] as String?,
      lessonType:
          $enumDecodeNullable(
            _$LessonTypeEnumMap,
            json['lessonType'],
            unknownValue: LessonType.unknown,
          ) ??
          LessonType.lesson,
      lessonStatus:
          $enumDecodeNullable(
            _$LessonStatusEnumMap,
            json['lessonStatus'],
            unknownValue: LessonStatus.unknown,
          ) ??
          LessonStatus.locked,
      isFirstLevelLesson: json['isFirstLevelLesson'] as bool? ?? false,
    );

Map<String, dynamic> _$LessonHomeModelToJson(LessonHomeModel instance) =>
    <String, dynamic>{
      'lessonId': instance.lessonId,
      'levelName': instance.levelName,
      'lessonName': instance.lessonName,
      'lessonType': _$LessonTypeEnumMap[instance.lessonType]!,
      'lessonStatus': _$LessonStatusEnumMap[instance.lessonStatus]!,
      'isFirstLevelLesson': instance.isFirstLevelLesson,
    };

const _$LessonTypeEnumMap = {
  LessonType.lesson: 'lesson',
  LessonType.finalLevelQuiz: 'finalLevelQuiz',
  LessonType.finalLevelQuizLower: 'finallevelQuiz',
  LessonType.unknown: 'unknown',
};

const _$LessonStatusEnumMap = {
  LessonStatus.completed: 'completed',
  LessonStatus.inProgress: 'inProgress',
  LessonStatus.locked: 'locked',
  LessonStatus.unknown: 'unknown',
};
