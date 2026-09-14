import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/features/challenges/presentation/views/challenges_view.dart';
import 'package:volt/features/games/presentation/views/games_view.dart';
import 'package:volt/features/home/presentation/views/home_view.dart';
import 'package:volt/features/learn/presentation/views/learn_view.dart';
import 'package:volt/features/main_layout/presentation/cubits/main_layout_cubit/main_layout_cubit.dart';
import 'package:volt/features/main_layout/presentation/widgets/main_nav_bar.dart';
import 'package:volt/features/profile/presentation/views/profile_view.dart';

class MainLayoutView extends StatelessWidget {
  const MainLayoutView({super.key});

  final List<Widget> _screens = const [
    HomeView(),
    LearnView(),
    ChallengesView(),
    GamesView(),
    ProfileView(),
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
