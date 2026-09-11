import 'option_model.dart';

enum QuestionType { mcq, imageChoice, trueFalse, fillInBlank, wordChips }

class QuestionModel {
  final String id;
  final String title;
  final QuestionType type;
  final List<OptionModel> options;
  final dynamic correctAnswer;

  QuestionModel({
    required this.id,
    required this.title,
    required this.type,
    this.options = const [],
    required this.correctAnswer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? '',
      title: json['title'] ?? json['questionText'] ?? '',
      type: _parseType(json['type']),
      options: (json['options'] as List? ?? []).map((e) => OptionModel.fromJson(e)).toList(),
      correctAnswer: json['correctAnswer'] ?? json['correctOptionId'],
    );
  }

  static QuestionType _parseType(String? typeStr) {
    switch (typeStr) {
      case 'image_choice':
        return QuestionType.imageChoice;
      case 'true_false':
        return QuestionType.trueFalse;
      case 'fill_blank':
        return QuestionType.fillInBlank;
      case 'word_chips':
        return QuestionType.wordChips;
      default:
        return QuestionType.mcq;
    }
  }
}
