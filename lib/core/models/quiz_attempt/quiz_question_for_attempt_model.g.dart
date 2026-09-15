// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_question_for_attempt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizQuestionForAttemptModel _$QuizQuestionForAttemptModelFromJson(
  Map<String, dynamic> json,
) => QuizQuestionForAttemptModel(
  questionId: (json['questionId'] as num).toInt(),
  questionText: json['questionText'] as String?,
  questionType: $enumDecode(
    _$QuestionTypeEnumMap,
    json['questionType'],
    unknownValue: QuestionType.unknown,
  ),
  imageUrl: json['imageUrl'] as String?,
  difficulty: $enumDecode(
    _$QuestionDifficultyEnumMap,
    json['difficulty'],
    unknownValue: QuestionDifficulty.unknown,
  ),
  displayOrder: (json['displayOrder'] as num).toInt(),
  points: (json['points'] as num).toInt(),
  currentHint: json['currentHint'] as String?,
  options: (json['options'] as List<dynamic>?)
      ?.map((e) => QuizAnswerOptionModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$QuizQuestionForAttemptModelToJson(
  QuizQuestionForAttemptModel instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'questionText': instance.questionText,
  'questionType': _$QuestionTypeEnumMap[instance.questionType]!,
  'imageUrl': instance.imageUrl,
  'difficulty': _$QuestionDifficultyEnumMap[instance.difficulty]!,
  'displayOrder': instance.displayOrder,
  'points': instance.points,
  'currentHint': instance.currentHint,
  'options': instance.options?.map((e) => e.toJson()).toList(),
};

const _$QuestionTypeEnumMap = {
  QuestionType.multipleChoice: 'MultipleChoice',
  QuestionType.trueFalse: 'TrueFalse',
  QuestionType.essay: 'Essay',
  QuestionType.unknown: 'unknown',
};

const _$QuestionDifficultyEnumMap = {
  QuestionDifficulty.easy: 'Easy',
  QuestionDifficulty.medium: 'Medium',
  QuestionDifficulty.hard: 'Hard',
  QuestionDifficulty.advanced: 'Advanced',
  QuestionDifficulty.unknown: 'unknown',
};
