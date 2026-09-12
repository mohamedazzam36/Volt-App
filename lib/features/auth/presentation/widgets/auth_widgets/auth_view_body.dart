import 'package:flutter/material.dart';
import 'package:volt/core/shared_widgets/app_clouds_background/backgrounds/app_clouds_background_layout.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_body.dart';

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppCloudsBackgroundLayout(
      bottomBaseColor: AppColors.brandSecondaryGreen,
      bodyWidget: const AuthBody(),
    );
  }
}
