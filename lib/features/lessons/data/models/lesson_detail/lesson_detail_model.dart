import 'package:json_annotation/json_annotation.dart';

import 'lesson_content_model.dart';

part 'lesson_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LessonDetailModel {
  final int id;
  final int levelId;
  final String? title;
  final String? description;
  final int sortOrder;
  final bool isPublished;
  final DateTime createdAt;
  final List<LessonContentModel>? contents;

  LessonDetailModel({
    required this.id,
    required this.levelId,
    this.title,
    this.description,
    required this.sortOrder,
    required this.isPublished,
    required this.createdAt,
    this.contents,
  });

  factory LessonDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LessonDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$LessonDetailModelToJson(this);
}
