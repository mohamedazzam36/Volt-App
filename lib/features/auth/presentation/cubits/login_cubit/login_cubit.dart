import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
}
