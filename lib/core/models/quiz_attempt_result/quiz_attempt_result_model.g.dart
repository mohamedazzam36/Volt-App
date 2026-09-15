// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_attempt_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAttemptResultModel _$QuizAttemptResultModelFromJson(
  Map<String, dynamic> json,
) => QuizAttemptResultModel(
  attemptId: (json['attemptId'] as num).toInt(),
  quizId: (json['quizId'] as num).toInt(),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
  totalQuestions: (json['totalQuestions'] as num).toInt(),
  autoGradedQuestions: (json['autoGradedQuestions'] as num).toInt(),
  pendingEssayQuestions: (json['pendingEssayQuestions'] as num).toInt(),
  essayResults: (json['essayResults'] as List<dynamic>?)
      ?.map((e) => EssayResultModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  correctAnswers: (json['correctAnswers'] as num).toInt(),
  wrongAnswers: (json['wrongAnswers'] as num).toInt(),
  scorePercentage: (json['scorePercentage'] as num).toDouble(),
  totalPoints: (json['totalPoints'] as num).toInt(),
  earnedPoints: (json['earnedPoints'] as num).toInt(),
  pendingPoints: (json['pendingPoints'] as num).toInt(),
  language: json['language'] as String?,
  languageFallbackApplied: json['languageFallbackApplied'] as bool,
  hintsStatus: $enumDecode(
    _$HintsStatusEnumMap,
    json['hintsStatus'],
    unknownValue: HintsStatus.unknown,
  ),
  retryQuestions: (json['retryQuestions'] as List<dynamic>?)
      ?.map(
        (e) => QuizQuestionForAttemptModel.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$QuizAttemptResultModelToJson(
  QuizAttemptResultModel instance,
) => <String, dynamic>{
  'attemptId': instance.attemptId,
  'quizId': instance.quizId,
  'completedAt': instance.completedAt?.toIso8601String(),
  'totalQuestions': instance.totalQuestions,
  'autoGradedQuestions': instance.autoGradedQuestions,
  'pendingEssayQuestions': instance.pendingEssayQuestions,
  'essayResults': instance.essayResults?.map((e) => e.toJson()).toList(),
  'correctAnswers': instance.correctAnswers,
  'wrongAnswers': instance.wrongAnswers,
  'scorePercentage': instance.scorePercentage,
  'totalPoints': instance.totalPoints,
  'earnedPoints': instance.earnedPoints,
  'pendingPoints': instance.pendingPoints,
  'language': instance.language,
  'languageFallbackApplied': instance.languageFallbackApplied,
  'hintsStatus': _$HintsStatusEnumMap[instance.hintsStatus]!,
  'retryQuestions': instance.retryQuestions?.map((e) => e.toJson()).toList(),
};

const _$HintsStatusEnumMap = {
  HintsStatus.notRequired: 'NotRequired',
  HintsStatus.generated: 'Generated',
  HintsStatus.partial: 'Partial',
  HintsStatus.unavailable: 'Unavailable',
  HintsStatus.unknown: 'unknown',
};
