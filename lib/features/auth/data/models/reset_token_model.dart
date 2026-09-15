class ResetTokenModel {
  final String resetToken;
  final DateTime resetTokenExpiresAt;
  ResetTokenModel({
    required this.resetToken,
    required this.resetTokenExpiresAt,
  });

  factory ResetTokenModel.fromJson(Map<String, dynamic> json) => ResetTokenModel(
    resetToken: json["resetToken"],
    resetTokenExpiresAt: DateTime.parse(json["resetTokenExpiresAt"]),
  );
}
