import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  // الـ Initial State هنا هتاخد الـ default index اللي هو 0 (الهوم)
  MainLayoutCubit() : super(const MainLayoutState(currentIndex: 0));

  void changeTab(int index) {
    emit(MainLayoutState(currentIndex: index));
  }
}
