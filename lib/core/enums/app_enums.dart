import 'package:json_annotation/json_annotation.dart';

enum QuestionType {
  @JsonValue('MultipleChoice')
  multipleChoice,
  @JsonValue('TrueFalse')
  trueFalse,
  @JsonValue('Essay')
  essay,
  unknown,
}

enum QuestionDifficulty {
  @JsonValue('Easy')
  easy,
  @JsonValue('Medium')
  medium,
  @JsonValue('Hard')
  hard,
  @JsonValue('Advanced')
  advanced,
  unknown,
}

enum LessonContentType {
  @JsonValue('Text')
  text,
  @JsonValue('Image')
  image,
  @JsonValue('TextAndImage')
  textAndImage,
  unknown,
}

enum HintsStatus {
  @JsonValue('NotRequired')
  notRequired,
  @JsonValue('Generated')
  generated,
  @JsonValue('Partial')
  partial,
  @JsonValue('Unavailable')
  unavailable,
  unknown,
}

enum EssayAnswerStatus {
  @JsonValue('Pending')
  pending,
  @JsonValue('Graded')
  graded,
  @JsonValue('NotGraded')
  notGraded,
  unknown,
}

enum PlacementStatus {
  @JsonValue('Required')
  required,
  @JsonValue('Optional')
  optional,
  @JsonValue('InProgress')
  inProgress,
  @JsonValue('Completed')
  completed,
  @JsonValue('Unavailable')
  unavailable,
  unknown,
}

enum QuizType {
  @JsonValue('LevelAssessment')
  levelAssessment,
  @JsonValue('LessonQuiz')
  lessonQuiz,
  @JsonValue('LessonReview')
  lessonReview,
  @JsonValue('Standalone')
  standalone,
  @JsonValue('Placement')
  placement,
  unknown,
}

enum UserRole {
  @JsonValue('Parent')
  parent,
  @JsonValue('Child')
  child,
  unknown,
}

enum AuthProvider {
  @JsonValue('Email')
  email,
  @JsonValue('Google')
  google,
  @JsonValue('Guest')
  guest,
  unknown,
}

@JsonEnum()
enum LessonType {
  @JsonValue('lesson')
  lesson,
  @JsonValue('finalLevelQuiz')
  finalLevelQuiz,
  @JsonValue('finallevelQuiz')
  finalLevelQuizLower,
  unknown,
}

@JsonEnum()
enum LessonStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('locked')
  locked,
  unknown,
}
