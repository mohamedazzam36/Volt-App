import 'package:volt/core/models/user_model.dart';

import 'auth_tokens_model.dart';

class AuthResponseModel {
  final bool success;
  final String message;
  final UserModel user;
  final AuthTokensModel tokens;

  const AuthResponseModel({
    required this.success,
    required this.message,
    required this.user,
    required this.tokens,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return AuthResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      user: UserModel.fromJson(data),
      tokens: AuthTokensModel.fromJson(data),
    );
  }
}
