import 'package:volt/core/network/api_endpoints.dart';
import 'package:volt/core/network/api_service.dart';
import 'package:volt/features/auth/data/models/auth_response_model.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';

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
}
