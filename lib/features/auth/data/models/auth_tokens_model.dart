class AuthTokensModel {
  final String accessToken;
  final String refreshToken;
  final DateTime? accessTokenExpiresAt;

  const AuthTokensModel({
    required this.accessToken,
    required this.refreshToken,
    this.accessTokenExpiresAt,
  });

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      accessTokenExpiresAt: json['accessTokenExpiresAt'] != null
          ? DateTime.tryParse(json['accessTokenExpiresAt'] as String)
          : null,
    );
  }
}
