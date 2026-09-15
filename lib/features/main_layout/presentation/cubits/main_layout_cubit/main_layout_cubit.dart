import 'package:bloc/bloc.dart';

part 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(const MainLayoutState(currentIndex: 0));

  void changeTab(int index) {
    emit(MainLayoutState(currentIndex: index));
  }
}
