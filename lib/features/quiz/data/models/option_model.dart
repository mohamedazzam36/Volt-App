class OptionModel {
  final String id;
  final String? text;
  final String? imageUrl;

  OptionModel({
    required this.id,
    this.text,
    this.imageUrl,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] ?? '',
      text: json['text'],
      imageUrl: json['imageUrl'],
    );
  }
}