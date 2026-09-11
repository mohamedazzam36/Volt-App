import 'package:volt/core/network/api_endpoints.dart';
import 'package:volt/core/network/api_service.dart';
import 'package:volt/features/auth/data/models/auth_response_model.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';
import 'package:volt/features/auth/data/models/reset_token_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> register(
    RegisterRequestModel request,
  );

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> continueWithGoogle();
  Future<AuthResponseModel> getProfile();
  Future<void> forgetPassword(String email);
  Future<ResetTokenModel> verifyOtpCode({required String email, required String otpCode});
  Future<void> resetPassword({
    required String email,
    required String password,
    required String resetToken,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSourceImpl(this._apiService);

  @override
  Future<AuthResponseModel> continueWithGoogle() async {
    throw UnimplementedError();
  }

  @override
  Future<AuthResponseModel> login({required String email, required String password}) async {
    final req = await _apiService.post(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
    );
    return AuthResponseModel.fromJson(req);
  }

  @override
  Future<AuthResponseModel> register(RegisterRequestModel request) async {
    final req = await _apiService.post(
      ApiEndpoints.register,
      data: request.toJson(),
    );
    return AuthResponseModel.fromJson(req);
  }

  @override
  Future<AuthResponseModel> getProfile() async {
    final req = await _apiService.get(
      ApiEndpoints.userMe,
    );
    return AuthResponseModel.fromJson(req);
  }

  @override
  Future<void> forgetPassword(String email) async {
    await _apiService.post(ApiEndpoints.forgotPassword, data: {"email": email});
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String password,
    required String resetToken,
  }) async {
    await _apiService.post(
      ApiEndpoints.resetPassword,
      data: {"email": email, "newPassword": password, "resetToken": resetToken},
    );
  }

  @override
  Future<ResetTokenModel> verifyOtpCode({required String email, required String otpCode}) async {
    final req = await _apiService.post(
      ApiEndpoints.verifyResetOtp,
      data: {"email": email, "otp": otpCode},
    );
    return ResetTokenModel.fromJson(req);
  }
}
