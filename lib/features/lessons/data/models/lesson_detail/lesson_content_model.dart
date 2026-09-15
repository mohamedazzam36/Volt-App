import 'package:json_annotation/json_annotation.dart';
import 'package:volt/core/enums/app_enums.dart';

part 'lesson_content_model.g.dart';

@JsonSerializable()
class LessonContentModel {
  final int id;
  final int lessonId;
  final int contentTypeId;
  @JsonKey(
    unknownEnumValue: LessonContentType.unknown,
    defaultValue: LessonContentType.textAndImage,
  )
  final LessonContentType contentTypeName;
  final String? content;
  final String? mediaUrl;
  final int sortOrder;

  LessonContentModel({
    required this.id,
    required this.lessonId,
    required this.contentTypeId,
    required this.contentTypeName,
    this.content,
    this.mediaUrl,
    required this.sortOrder,
  });

  factory LessonContentModel.fromJson(Map<String, dynamic> json) =>
      _$LessonContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$LessonContentModelToJson(this);
}
