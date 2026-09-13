part of 'main_layout_cubit.dart';

class MainLayoutState extends Equatable {
  final int currentIndex;

  const MainLayoutState({this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}
