import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volt/core/theme/app_colors.dart';

class NavBarItem extends StatelessWidget {
  final bool isActive;
  final String iconPath;
  final VoidCallback onTap;
  final bool isLocked;

  const NavBarItem({
    super.key,
    required this.isActive,
    required this.iconPath,
    required this.onTap,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLocked ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 55,
        height: 55,
        padding: const EdgeInsets.all(12),
        decoration: isActive && !isLocked
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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Opacity(
              opacity: isLocked ? 0.4 : 1.0,
              child: SvgPicture.asset(iconPath),
            ),
            if (isLocked)
              Positioned(
                bottom: -8,
                right: -8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.surfaceDefault,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_rounded,
                    color: Colors.grey.shade400,
                    size: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
