import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';

import '../../../data/models/register_request_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;
  RegisterCubit(this._authRepo) : super(RegisterInitial());

  Future<void> register(RegisterRequestModel request) async {
    emit(RegisterLoading());
    final result = await _authRepo.register(request);
    result.fold(
      (failure) {
        emit(RegisterError(errorMessage: failure.errMessage));
      },
      (user) {
        emit(RegisterSuccess(user: user));
      },
    );
  }
}
