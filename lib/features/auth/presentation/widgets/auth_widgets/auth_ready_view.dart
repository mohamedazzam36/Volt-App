import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/animated_battery_loader.dart';

class AuthReadyView extends StatefulWidget {
  const AuthReadyView({super.key});

  @override
  State<AuthReadyView> createState() => _AuthReadyViewState();
}

class _AuthReadyViewState extends State<AuthReadyView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceSubtle,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(top: 100, left: 40, child: _BackgroundSparkle()),
            const Positioned(top: 200, right: 35, child: _BackgroundSparkle()),
            const Positioned(bottom: 350, left: 20, child: _BackgroundSparkle()),
            const Positioned(bottom: 200, right: 50, child: _BackgroundSparkle()),

            Column(
              children: [
                const Spacer(flex: 2),
                SpeakingRobot(
                  message: AuthStrings.letsGo,
                  robotImagePath: Assets.images.authRobotDance.path,
                  messageShiftingRatio: 0.58,
                  spaceAfterMessage: 6,
                  robotWidth: (context.width * 0.5).clamp(180, 250),
                ),

                const Spacer(flex: 1),
                AnimatedBatteryLoader(
                  onLoadComplete: () {
                    debugPrint('البطارية شحنت 100%!');
                  },
                ),
                const Spacer(flex: 2),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                  child: CustomElevatedButton(
                    onTap: () {
                      context.pushNamedAndRemoveAll(Routes.quiz);
                    },
                    text: AuthStrings.startGame,
                    width: double.infinity,
                    backgroundColor: AppColors.brandSecondaryGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// ويدجت صغيرة لرسم النجمة الصفراء (Sparkle) اللي في الخلفية
// ---------------------------------------------------------
class _BackgroundSparkle extends StatelessWidget {
  const _BackgroundSparkle();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.bolt,
      color: AppColors.accentYellow,
      size: 24,
    );
  }
}
