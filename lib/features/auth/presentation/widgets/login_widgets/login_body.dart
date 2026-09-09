import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/back_ghost_button.dart';

class LoginBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpeakingRobot(
          message: AuthStrings.login,
          robotImagePath: Assets.images.rasingLeftHandRobot.path,
          messageShiftingRatio: .65,
        ),
        const SizedBox(height: 42),
        CustomElevatedButton(
          text: AuthStrings.createAccount,
          color: AppColors.brandSecondaryYellow,
          textColor: AppColors.textOnBrand,
          onTap: () => context.pushNamed(Routes.register),
        ),
        const SizedBox(height: 16),
        const BackGhostButton(),
      ],
    );
  }
}
