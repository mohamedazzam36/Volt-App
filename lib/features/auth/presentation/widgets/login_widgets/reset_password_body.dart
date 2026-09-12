import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_text_field.dart';
import 'package:volt/core/shared_widgets/back_ghost_button.dart';

class ResetPasswordBody extends StatelessWidget {
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityToggle;
  final ValueChanged<String> onPasswordChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;
  final bool isLoading;

  const ResetPasswordBody({
    super.key,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.onVisibilityToggle,
    required this.onPasswordChanged,
    required this.onSubmit,
    required this.onBackToLogin,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SpeakingRobot(
          message: AuthStrings.letsRecoverPassword,
          robotImagePath: Assets.images.letsRecoverPasswordRobot.path,
          messageShiftingRatio: .5,
        ),
        const SizedBox(height: 60),
        AuthTextField.password(
          controller: passwordController,
          obscureText: !isPasswordVisible,
          onVisibilityToggle: onVisibilityToggle,
          onChanged: onPasswordChanged,
        ),
        const SizedBox(height: 24),
        CustomElevatedButton(
          text: AuthStrings.resetPasswordButton,
          backgroundColor: AppColors.brandSecondaryGreen, // Green color
          textColor: AppColors.textOnBrand,
          width: double.infinity,
          onTap: passwordController.text.isNotEmpty && !isLoading ? onSubmit : () {},
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
