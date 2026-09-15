part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserModel user;
  LoginSuccess({required this.user});
}

final class LoginError extends LoginState {
  final String errorMessage;
  LoginError({required this.errorMessage});
}

final class ForgetPasswordLoading extends LoginState {}

final class ForgetPasswordSuccess extends LoginState {}

final class ForgetPasswordError extends LoginState {
  final String errorMessage;
  ForgetPasswordError({required this.errorMessage});
}

final class VerifyOtpLoading extends LoginState {}

final class VerifyOtpSuccess extends LoginState {
  final String resetToken;
  VerifyOtpSuccess({required this.resetToken});
}

final class VerifyOtpError extends LoginState {
  final String errorMessage;
  VerifyOtpError({required this.errorMessage});
}

final class ResetPasswordLoading extends LoginState {}

final class ResetPasswordSuccess extends LoginState {}

final class ResetPasswordError extends LoginState {
  final String errorMessage;
  ResetPasswordError({required this.errorMessage});
}
