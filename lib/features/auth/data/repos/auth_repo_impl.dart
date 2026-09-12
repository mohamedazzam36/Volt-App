import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:volt/core/errors/api_failures.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';
import 'package:volt/features/auth/data/models/reset_token_model.dart';

import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepoImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, UserModel>> register(RegisterRequestModel request) async {
    try {
      final result = await _remoteDataSource.register(request);

      await _localDataSource.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
      );
      return Right(result.user);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(email: email, password: password);

      await _localDataSource.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
      );

      return Right(result.user);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> continueWithGoogle() async {
    try {
      final result = await _remoteDataSource.continueWithGoogle();

      await _localDataSource.saveTokens(
        accessToken: result.tokens.accessToken,
        refreshToken: result.tokens.refreshToken,
      );

      return Right(result.user);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> checkAuthStatus() async {
    try {
      final token = await _localDataSource.getAccessToken();
      if (token == null || token.isEmpty) {
        return Left(UnknownFailure('No token found'));
      }
      // final result = await _remoteDataSource.getProfile();
      //TODO handle this
      return const Right(
        UserModel(
          age: 1,
          authProvider: '',
          fullName: '',
          role: '',
          userId: '',
        ),
      );
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _localDataSource.clearAll();
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure('Failed to clear local data'));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      await _remoteDataSource.forgetPassword(email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String password,
    required String resetToken,
  }) async {
    try {
      await _remoteDataSource.resetPassword(
        email: email,
        password: password,
        resetToken: resetToken,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResetTokenModel>> verifyOtpCode({
    required String email,
    required String otpCode,
  }) async {
    try {
      final result = await _remoteDataSource.verifyOtpCode(email: email, otpCode: otpCode);
      return Right(result);
    } on DioException catch (e) {
      return Left(ApiFailure.fromDioException(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
