import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/features/home/presentation/views/home_view.dart';
import 'package:volt/features/main_layout/presentation/cubits/main_layout_cubit/main_layout_cubit.dart';
import 'package:volt/features/main_layout/presentation/widgets/main_nav_bar.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  final List<Widget> _screens = const [
    HomeView(),
    Center(child: Text("Learn")),
    Center(child: Text("Simulator")),
    Center(child: Text("Games")),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: _screens,
          ),
          bottomNavigationBar: MainBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<MainLayoutCubit>().changeTab(index);
            },
          ),
        );
      },
    );
  }
}
