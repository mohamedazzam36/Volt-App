import 'dart:ui';

class LessonItemModel {
  final String id;
  final String title;
  final String message;
  final String robotImagePath;
  final String? contentImagePath; // صورة المحتوى السفلي (سيارة، تلفزيون، إلخ)
  final bool isOneLine;
  final Color? buttonColor;

  const LessonItemModel({
    required this.id,
    required this.title,
    required this.message,
    required this.robotImagePath,
    this.contentImagePath,
    this.isOneLine = true,
    this.buttonColor,
  });
}