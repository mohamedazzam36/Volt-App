import 'package:volt/core/storage/secure_storage_helper.dart';

abstract class AuthLocalDataSource {
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  Future<String?> getAccessToken();
  Future<void> clearAll();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageHelper _secureStorageHelper;

  AuthLocalDataSourceImpl(this._secureStorageHelper);

  @override
  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _secureStorageHelper.saveAccessToken(accessToken);
    await _secureStorageHelper.saveRefreshToken(refreshToken);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorageHelper.getAccessToken();
  }

  @override
  Future<void> clearAll() async {
    await _secureStorageHelper.clearAll();
  }
}
