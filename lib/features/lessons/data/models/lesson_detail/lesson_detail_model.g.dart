// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonDetailModel _$LessonDetailModelFromJson(Map<String, dynamic> json) =>
    LessonDetailModel(
      id: (json['id'] as num).toInt(),
      levelId: (json['levelId'] as num).toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      sortOrder: (json['sortOrder'] as num).toInt(),
      isPublished: json['isPublished'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => LessonContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LessonDetailModelToJson(LessonDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'levelId': instance.levelId,
      'title': instance.title,
      'description': instance.description,
      'sortOrder': instance.sortOrder,
      'isPublished': instance.isPublished,
      'createdAt': instance.createdAt.toIso8601String(),
      'contents': instance.contents?.map((e) => e.toJson()).toList(),
    };
