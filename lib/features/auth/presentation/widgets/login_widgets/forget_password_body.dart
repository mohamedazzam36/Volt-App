import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';
import 'package:volt/core/shared_widgets/back_ghost_button.dart';

class ForgetPasswordBody extends StatelessWidget {
  final TextEditingController emailController;
  final bool isEmailValid;
  final String? emailError;
  final ValueChanged<String> onEmailChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;
  final bool isLoading;

  const ForgetPasswordBody({
    super.key,
    required this.emailController,
    required this.isEmailValid,
    this.emailError,
    required this.onEmailChanged,
    required this.onSubmit,
    required this.onBackToLogin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AuthStrings.forgetPasswordTitle,
          style: AppStyles.bold24.responsive(context),
        ),
        const SizedBox(height: 8),
        Text(
          AuthStrings.forgetPasswordSubTitle,
          style: AppStyles.regular16
              .responsive(context)
              .copyWith(
                color: AppColors.textSecondary,
              ),
        ),
        const SizedBox(height: 40),
        Image.asset(
          Assets.images.forgotPasswordRobot.path,
          width: (context.width * 0.4).clamp(120.0, 250.0),
        ),
        const SizedBox(height: 40),
        AuthTextField.email(
          controller: emailController,
          hintText: AuthStrings.emailOrUsernameHint,
          onChanged: onEmailChanged,
          isValid: isEmailValid,
          errorText: emailError,
        ),
        const SizedBox(height: 24),
        CustomElevatedButton(
          text: AuthStrings.useVerificationCode,
          backgroundColor: AppColors.brandSecondaryOrange,
          textColor: AppColors.textOnBrand,
          width: double.infinity,
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
