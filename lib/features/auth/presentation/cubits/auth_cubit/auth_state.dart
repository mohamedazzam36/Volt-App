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
