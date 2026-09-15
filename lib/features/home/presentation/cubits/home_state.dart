part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
}

final class HomeLoaded extends HomeState {
  final List<LessonHomeModel> lessons;
  final Map<String, List<LessonHomeModel>> groupedLevels;

  const HomeLoaded({required this.lessons, required this.groupedLevels});
}
