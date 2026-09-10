import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';

class AuthBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpeakingRobot(
          message: AuthStrings.robotWelcome,
          robotImagePath: Assets.images.rasingLeftHandRobot.path,
          messageShiftingRatio: .65,
        ),
        const SizedBox(height: 42),
        CustomElevatedButton(
          text: AuthStrings.createAccount,
          backgroundColor: AppColors.brandSecondaryGreen,
          textColor: AppColors.textOnBrand,
          onTap: () => context.pushNamed(Routes.register),
        ),
        const SizedBox(height: 12),
        CustomElevatedButton(
          text: AuthStrings.login,
          backgroundColor: AppColors.textOnBrand,
          textColor: AppColors.textPrimary,
          onTap: () => context.pushNamed(Routes.login),
        ),
      ],
    );
  }
}
