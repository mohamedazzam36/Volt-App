import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_google_button.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_or_widget.dart';

class AuthButtonsSection extends StatelessWidget {
  final bool isValid;
  final String buttonText;
  final Color? activeColor;
  final VoidCallback onMainButtonTap;
  final VoidCallback onGoogleTap;

  const AuthButtonsSection({
    super.key,
    required this.isValid,
    this.buttonText = CommonStrings.next,
    this.activeColor,
    required this.onMainButtonTap,
    required this.onGoogleTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          onTap: onMainButtonTap,
          backgroundColor: isValid ? activeColor : AppColors.neutralSlate,
          textColor: Colors.white,
          text: buttonText,
          width: double.infinity,
        ),
        const SizedBox(height: 24),
        const AuthOrWidget(),
        const SizedBox(height: 24),
        AuthGoogleButton(
          onTap: onGoogleTap,
        ),
      ],
    );
  }
}
