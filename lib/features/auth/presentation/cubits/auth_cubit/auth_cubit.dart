import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(AuthInitial());
  final AuthRepo _authRepo;

  Future<void> checkAuthStatus() async {
    final result = await _authRepo.checkAuthStatus();
    result.fold(
      (failure) {
        emit(UnAuthenticated());
      },
      (user) {
        emit(Authenticated(user: user));
      },
    );
  }

  Future<void> logout() async {
    await _authRepo.logout();
    emit(UnAuthenticated());
  }
}
