import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/enums/app_enums.dart';
import 'package:volt/features/home/data/models/lesson_home_model.dart';
import 'package:volt/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> getPublishedLessons() async {
    emit(HomeLoading());
    final result = await _homeRepo.getPublishedLessons();
    result.fold(
      (failure) => emit(HomeError(message: failure.errMessage)),
      (lessons) {
        final grouped = _groupByLevel(lessons);
        emit(HomeLoaded(lessons: lessons, groupedLevels: grouped));
      },
    );
  }

  Map<String, List<LessonHomeModel>> _groupByLevel(List<LessonHomeModel> lessons) {
    final map = <String, List<LessonHomeModel>>{};
    for (final lesson in lessons) {
      final level = lesson.levelName ?? 'غير محدد';
      map.putIfAbsent(level, () => []).add(lesson);
    }
    return map;
  }

  LessonHomeModel? get inProgressLesson {
    final current = state;
    if (current is! HomeLoaded) return null;
    try {
      return current.lessons.firstWhere(
        (l) => l.lessonStatus == LessonStatus.inProgress,
      );
    } catch (_) {
      return null;
    }
  }
}
