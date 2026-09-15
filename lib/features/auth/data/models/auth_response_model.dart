import 'package:volt/core/models/user_model.dart';

import 'auth_tokens_model.dart';

class AuthResponseModel {
  final UserModel user;
  final AuthTokensModel tokens;

  const AuthResponseModel({
    required this.user,
    required this.tokens,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json),
      tokens: AuthTokensModel.fromJson(json),
    );
  }
}
