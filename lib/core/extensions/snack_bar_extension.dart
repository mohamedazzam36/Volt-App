import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

enum SnackBarType {
  success(
    backgroundColor: AppColors.surfaceGreenSoft,
    borderColor: AppColors.statusSuccess,
    iconColor: AppColors.statusSuccess,
    textColor: AppColors.textSuccess,
    icon: Icons.check_circle_outline_rounded,
  ),
  error(
    backgroundColor: AppColors.surfaceDefault,
    borderColor: AppColors.statusError,
    iconColor: AppColors.iconError,
    textColor: AppColors.textError,
    icon: Icons.error_outline_rounded,
  ),
  warning(
    backgroundColor: AppColors.surfaceYellowSoft,
    borderColor: AppColors.statusWarning,
    iconColor: AppColors.accentOrange,
    textColor: AppColors.textWarning,
    icon: Icons.warning_amber_rounded,
  ),
  info(
    backgroundColor: AppColors.surfaceBlueSoft,
    borderColor: AppColors.statusInfo,
    iconColor: AppColors.brandPrimary,
    textColor: AppColors.textBrandBlue,
    icon: Icons.info_outline_rounded,
  );

  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;

  const SnackBarType({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });
}

extension SnackBarContextExtension on BuildContext {
  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(this);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        duration: duration,
        behavior: SnackBarBehavior.floating,
        backgroundColor: type.backgroundColor,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: type.borderColor, width: 1.2),
        ),
        action: action,
        content: Row(
          children: [
            Icon(type.icon, color: type.iconColor, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: type.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
