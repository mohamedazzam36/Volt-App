import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

import '../widgets/loading_bar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.isOnboardingViewed});
  final bool isOnboardingViewed;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final DateTime _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();

    context.read<AuthCubit>().checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        final elapsed = DateTime.now().difference(_startTime);

        final remaining = const Duration(seconds: 3) - elapsed;

        if (!remaining.isNegative) {
          await Future.delayed(remaining);
        }

        if (!context.mounted) return;

        if (state is Authenticated) {
          context.pushReplacementNamed(Routes.mainLayout);
        } else if (state is UnAuthenticated) {
          if (widget.isOnboardingViewed) {
            context.pushReplacementNamed(Routes.auth);
          } else {
            context.pushReplacementNamed(Routes.onboarding);
          }
        }
      },
      child: Scaffold(
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
                messageShiftingRatio: .65,
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
      ),
    );
  }
}
