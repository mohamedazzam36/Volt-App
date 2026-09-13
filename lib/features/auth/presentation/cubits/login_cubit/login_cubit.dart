import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';

import '../../../../../core/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;
  LoginCubit(this._authRepo) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await _authRepo.login(email: email, password: password);
    result.fold(
      (failure) {
        emit(LoginError(errorMessage: failure.errMessage));
      },
      (user) {
        emit(LoginSuccess(user: user));
      },
    );
  }

  Future<void> forgetPassword(String email) async {
    emit(ForgetPasswordLoading());
    final result = await _authRepo.forgetPassword(email);
    result.fold(
      (failure) {
        emit(ForgetPasswordError(errorMessage: failure.errMessage));
      },
      (_) {
        emit(ForgetPasswordSuccess());
      },
    );
  }

  Future<void> verifyOtpCode({required String email, required String otpCode}) async {
    emit(VerifyOtpLoading());
    final result = await _authRepo.verifyOtpCode(email: email, otpCode: otpCode);
    result.fold(
      (failure) {
        emit(VerifyOtpError(errorMessage: failure.errMessage));
      },
      (resetTokenModel) {
        emit(VerifyOtpSuccess(resetToken: resetTokenModel.resetToken));
      },
    );
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String resetToken,
  }) async {
    emit(ResetPasswordLoading());
    final result = await _authRepo.resetPassword(
      email: email,
      password: password,
      resetToken: resetToken,
    );
    result.fold(
      (failure) {
        emit(ResetPasswordError(errorMessage: failure.errMessage));
      },
      (_) {
        emit(ResetPasswordSuccess());
      },
    );
  }
}
