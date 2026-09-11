import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ImageOptionCard extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;

  const ImageOptionCard({
    super.key,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.brandPrimary : AppColors.borderSubtle;
    final backgroundColor = isSelected ? AppColors.surfaceSoftBlue : AppColors.surfaceDefault;
    final bottomBorderColor = isSelected ? AppColors.brandPrimary : Colors.transparent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          color: bottomBorderColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          // إزاحة خفيفة للأعلى لتوليد إحساس الـ 3D السفلي
          margin: EdgeInsets.only(bottom: isSelected ? 4.0 : 0.0),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor,
              width: 2.0,
            ),
          ),
          child: Center(
            child: imageUrl.startsWith('assets/')
                ? Image.asset(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textSecondary,
                      size: 32,
                    ),
                  )
                : Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textSecondary,
                      size: 32,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
