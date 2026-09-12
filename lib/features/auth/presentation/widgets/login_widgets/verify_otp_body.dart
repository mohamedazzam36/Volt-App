import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/back_ghost_button.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/custom_otp_input.dart';

class VerifyOtpBody extends StatelessWidget {
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;
  final VoidCallback onResend;
  final bool hasError;
  final bool isLoading;
  final int remainingSeconds;
  final bool isOtpComplete;
  final bool showEmptyError;

  const VerifyOtpBody({
    super.key,
    required this.onOtpChanged,
    required this.onSubmit,
    required this.onBackToLogin,
    required this.onResend,
    this.hasError = false,
    this.isLoading = false,
    required this.remainingSeconds,
    required this.isOtpComplete,
    this.showEmptyError = false,
  });

  String get timerText {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bool canResend = remainingSeconds == 0;

    return Column(
      children: [
        SizedBox(height: (context.height * 0.1).clamp(50, 100)),
        Text(
          AuthStrings.confirmAccountTitle,
          style: AppStyles.bold24.responsive(context),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            AuthStrings.confirmAccountSubTitle,
            textAlign: TextAlign.center,
            style: AppStyles.regular16.responsive(context).copyWith(color: AppColors.textSecondary),
          ),
        ),
        const SizedBox(height: 46),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomOtpInput(
              length: 6,
              hasError: hasError,
              showEmptyError: showEmptyError,
              onChanged: onOtpChanged,
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                canResend ? AuthStrings.resendCode : '${AuthStrings.resendCode} ($timerText)',
                style: AppStyles.regular12
                    .responsive(context)
                    .copyWith(
                      color: canResend
                          ? AppColors.textPrimary
                          : AppColors.textSecondary.withAlpha((255 * 0.5).toInt()),
                    ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 40),
        CustomElevatedButton(
          text: AuthStrings.confirmButton,
          onTap: !isLoading ? onSubmit : () {},
        ),
        const SizedBox(height: 16),
        BackGhostButton(
          text: AuthStrings.backToLogin,
          onTap: onBackToLogin,
        ),
      ],
    );
  }
}
