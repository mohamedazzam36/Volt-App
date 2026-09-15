// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonContentModel _$LessonContentModelFromJson(Map<String, dynamic> json) =>
    LessonContentModel(
      id: (json['id'] as num).toInt(),
      lessonId: (json['lessonId'] as num).toInt(),
      contentTypeId: (json['contentTypeId'] as num).toInt(),
      contentTypeName:
          $enumDecodeNullable(
            _$LessonContentTypeEnumMap,
            json['contentTypeName'],
            unknownValue: LessonContentType.unknown,
          ) ??
          LessonContentType.textAndImage,
      content: json['content'] as String?,
      mediaUrl: json['mediaUrl'] as String?,
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$LessonContentModelToJson(LessonContentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'contentTypeId': instance.contentTypeId,
      'contentTypeName': _$LessonContentTypeEnumMap[instance.contentTypeName]!,
      'content': instance.content,
      'mediaUrl': instance.mediaUrl,
      'sortOrder': instance.sortOrder,
    };

const _$LessonContentTypeEnumMap = {
  LessonContentType.text: 'Text',
  LessonContentType.image: 'Image',
  LessonContentType.textAndImage: 'TextAndImage',
  LessonContentType.unknown: 'unknown',
};
