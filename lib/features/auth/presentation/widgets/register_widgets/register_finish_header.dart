import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_app_bar.dart';

class RegisterFinishHeader extends StatelessWidget {
  final VoidCallback? onBackTap;

  const RegisterFinishHeader({
    super.key,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    final double headerHeight = (context.height * 0.26).clamp(250.0, 350.0);
    final double avatarRadius = (context.width * 0.23).clamp(50.0, 100.0);

    return SizedBox(
      height: headerHeight + avatarRadius,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: headerHeight,
            width: double.infinity,
            color: AppColors.brandSecondaryYellow,
          ),
          Positioned(
            bottom: 0,
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(Assets.images.authRobotDanceWithBackground.path),
            ),
          ),
          Positioned(
            top: 18,
            left: 16,
            right: 16,
            child: AuthAppBar(
              buttonText: AuthStrings.login,
              onButtonTap: () => context.pushAboveNamed(Routes.auth, Routes.login),
              onBackTap: onBackTap,
            ),
          ),
        ],
      ),
    );
  }
}
