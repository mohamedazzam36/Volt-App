import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/app_clouds_background_layout.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/login_widgets/login_body.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCloudsBackgroundLayout(
      headerStartFromLeft: true,
      bottomBaseColor: AppColors.brandSecondaryYellow,
      bodyWidget: LoginBody(),
    );
  }
}
