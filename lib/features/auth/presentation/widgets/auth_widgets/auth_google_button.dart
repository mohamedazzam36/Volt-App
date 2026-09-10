import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class AuthGoogleButton extends StatelessWidget {
  final VoidCallback onTap;

  const AuthGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.surfaceDefault,
          side: const BorderSide(color: AppColors.borderSubtle, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AuthStrings.googleSignIn,
              style: AppStyles.bold16
                  .responsive(context)
                  .copyWith(
                    color: AppColors.textPrimary,
                  ),
            ),
            const SizedBox(width: 12),
            Text(
              'G', // الأيقونة ملهاش علاقة بالـ Strings
              style: AppStyles.bold20
                  .responsive(context)
                  .copyWith(
                    color: AppColors.accentRed,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
