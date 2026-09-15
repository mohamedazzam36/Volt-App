import 'package:json_annotation/json_annotation.dart';

import '../../../../core/enums/app_enums.dart';

part 'lesson_home_model.g.dart';

@JsonSerializable()
class LessonHomeModel {
  final int lessonId;
  final String? levelName;
  final String? lessonName;

  @JsonKey(defaultValue: LessonType.lesson, unknownEnumValue: LessonType.unknown)
  final LessonType lessonType;

  @JsonKey(defaultValue: LessonStatus.locked, unknownEnumValue: LessonStatus.unknown)
  final LessonStatus lessonStatus;

  @JsonKey(defaultValue: false)
  final bool isFirstLevelLesson;

  LessonHomeModel({
    required this.lessonId,
    this.levelName,
    this.lessonName,
    this.lessonType = LessonType.lesson,
    this.lessonStatus = LessonStatus.locked,
    this.isFirstLevelLesson = false,
  });

  factory LessonHomeModel.fromJson(Map<String, dynamic> json) => _$LessonHomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$LessonHomeModelToJson(this);
}
