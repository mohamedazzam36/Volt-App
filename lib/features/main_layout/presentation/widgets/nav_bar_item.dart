import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/theme/app_colors.dart';

// متنساش تعمل import لملف AppColors

class NavBarItem extends StatelessWidget {
  final bool isActive;
  final String iconPath;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.isActive,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(12),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.surfaceBlueSoft,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColors.brandPrimary,
                  width: 2,
                ),
              )
            : const BoxDecoration(
                color: Colors.transparent,
              ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
