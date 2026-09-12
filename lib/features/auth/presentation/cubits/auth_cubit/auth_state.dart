part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

final class UnAuthenticated extends AuthState {}
