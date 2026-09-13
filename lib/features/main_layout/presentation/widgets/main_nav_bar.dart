import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/main_layout/presentation/widgets/nav_bar_item.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      decoration: const BoxDecoration(
        color: AppColors.surfaceDefault,
        border: Border(
          top: BorderSide(color: AppColors.borderDefault, width: 1.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavBarItem(
              isActive: currentIndex == 0,
              iconPath: Assets.svgs.homeNavIcon.path,
              onTap: () => onTap(0),
            ),
            NavBarItem(
              isActive: currentIndex == 1,
              iconPath: Assets.svgs.learnNavIcon.path,
              onTap: () => onTap(1),
            ),
            NavBarItem(
              isActive: currentIndex == 2,
              iconPath: Assets.svgs.challenagesNavIcon.path,
              onTap: () => onTap(2),
            ),
            NavBarItem(
              isActive: currentIndex == 3,
              iconPath: Assets.svgs.gamesNavIcon.path,
              onTap: () => onTap(3),
            ),
            NavBarItem(
              isActive: currentIndex == 4,
              iconPath: Assets.svgs.profileNavIcon.path,
              onTap: () => onTap(4),
            ),
          ],
        ),
      ),
    );
  }
}
