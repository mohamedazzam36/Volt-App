part of 'auth_cubit.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});
}

final class UnAuthenticated extends AuthState {}

final class AuthCheckingPlacement extends AuthState {}

/// Emitted when placement check resolves to "go to main layout"
final class AuthGoToMain extends AuthState {}

/// Emitted when placement check resolves to "go to quiz intro"
final class AuthGoToQuiz extends AuthState {}

final class AuthPlacementError extends AuthState {
  final String message;
  const AuthPlacementError({required this.message});
}
