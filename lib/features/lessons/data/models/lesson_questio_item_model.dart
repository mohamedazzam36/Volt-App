enum LessonQuestionType { none, trueFalse, multipleChoice, textInput }

class LessonQuestionItemModel {
  final String message;
  final bool isOneLine;
  final String? contentImagePath;
  final LessonQuestionType questionType;
  final List<String>? options;
  final dynamic correctAnswer;

  const LessonQuestionItemModel({
    required this.message,
    this.isOneLine = false,
    this.contentImagePath,
    this.questionType = LessonQuestionType.none,
    this.options,
    this.correctAnswer,
  });
}