import 'package:dartz/dartz.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';
import 'package:volt/features/auth/data/models/reset_token_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> register(RegisterRequestModel request);

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> continueWithGoogle();

  Future<Either<Failure, UserModel>> checkAuthStatus();
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, ResetTokenModel>> verifyOtpCode({
    required String email,
    required String otpCode,
  });
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String password,
    required String resetToken,
  });
}
