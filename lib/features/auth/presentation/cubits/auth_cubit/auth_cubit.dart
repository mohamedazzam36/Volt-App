import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/core/models/user_model.dart';
import 'package:volt/core/storage/cache_helper.dart';
import 'package:volt/core/storage/pref_keys.dart';
import 'package:volt/features/auth/data/repos/auth_repo.dart';
import 'package:volt/features/placement_quiz/data/repos/placement_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo, this._placementRepo, this._cacheHelper)
      : super(AuthInitial());

  final AuthRepo _authRepo;
  final PlacementRepo _placementRepo;
  final CacheHelper _cacheHelper;

  // ─── Auth status (called from splash) ──────────────────────────────────────────

  Future<void> checkAuthStatus() async {
    final result = await _authRepo.checkAuthStatus();
    result.fold(
      (failure) {
        if (state is! UnAuthenticated) {
          emit(UnAuthenticated());
        }
      },
      (user) {
        // بعد التحقق من التوكن – شيك كاش الـ placement
        if (_cacheHelper.getBool(PrefKeys.isPlacementCompleted) == true) {
          emit(AuthGoToMain()); // كويز خلص قبل كده – روح مباشرة للـ mainLayout
        } else {
          emit(Authenticated(user: user)); // كويز لسه مخلصش – روح لـ authReady (زرار)
        }
      },
    );
  }

  Future<void> logout() async {
    if (state is UnAuthenticated) return;
    await _authRepo.logout();
    emit(UnAuthenticated());
  }

  // ─── Placement check (called after login / register success) ─────────────────

  Future<void> checkPlacementAndNavigate() async {
    // ✅ كويز خلص قبل كده – امشي على mainLayout مباشرة
    if (_cacheHelper.getBool(PrefKeys.isPlacementCompleted) == true) {
      emit(AuthGoToMain());
      return;
    }

    emit(AuthCheckingPlacement());
    final result = await _placementRepo.getPlacementStatus();

    result.fold(
      (failure) => emit(AuthPlacementError(message: failure.errMessage)),
      (statusModel) async {
        if (statusModel.status == PlacementStatus.completed) {
          // 💾 احفظ فالكاش عشان المرات الجاية
          await _cacheHelper.setBool(PrefKeys.isPlacementCompleted, true);
          emit(AuthGoToMain());
        } else if (statusModel.status == PlacementStatus.required ||
            statusModel.status == PlacementStatus.inProgress) {
          emit(AuthGoToQuiz());
        } else {
          // optional / unavailable / unknown
          emit(AuthGoToMain());
        }
      },
    );
  }
}
