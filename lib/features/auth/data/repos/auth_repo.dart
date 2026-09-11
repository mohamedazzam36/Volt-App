import 'package:dartz/dartz.dart';
import 'package:volt/core/errors/failures.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/features/auth/data/models/register_request_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserModel>> register(RegisterRequestModel request);

  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> continueWithGoogle();

  Future<Either<Failure, UserModel>> checkAuthStatus();
  Future<Either<Failure, void>> logout();
}
