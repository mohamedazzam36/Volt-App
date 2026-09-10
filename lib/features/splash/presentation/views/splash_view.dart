import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import '../widgets/loading_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.pushReplacementNamed(Routes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.brandPrimary,
              AppColors.surfaceBlueSoft,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            SpeakingRobot(
              message: SplashStrings.chargingMessage,
              robotImagePath: Assets.images.rasingLeftHandRobot.path,
              messageShiftingRatio: 0.65,
            ),

            const SizedBox(height: 20),

            Text(
              CommonStrings.appName,
              style: AppStyles.black36.responsive(context),
            ),

            Text(
              SplashStrings.byCtrlZ,
              style: AppStyles.semiBold12
                  .responsive(context)
                  .copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),

            const SizedBox(height: 25),

            const LoadingBar(),

            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}