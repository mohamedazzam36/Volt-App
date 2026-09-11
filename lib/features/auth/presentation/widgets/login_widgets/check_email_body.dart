import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/back_ghost_button.dart';

class CheckEmailBody extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onBackToLogin;

  const CheckEmailBody({
    super.key,
    required this.onNext,
    required this.onBackToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: (context.height * 0.1).clamp(70, 140)),
        Text(
          AuthStrings.checkEmailTitle,
          style: AppStyles.bold24.responsive(context),
        ),
        const SizedBox(height: 60),
        Image.asset(
          Assets.images.checkEmailRobot.path,
          width: (context.width * 0.5).clamp(150.0, 300.0),
        ),
        const SizedBox(height: 60),
        CustomElevatedButton(
          text: CommonStrings.next,
          backgroundColor: AppColors.brandSecondaryPurple, // Purple/blue background
          onTap: onNext,
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
