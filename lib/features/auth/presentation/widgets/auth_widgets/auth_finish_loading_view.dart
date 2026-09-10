import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';

import 'sequential_dots_loading.dart';

class AuthFinishLoadingView extends StatefulWidget {
  const AuthFinishLoadingView({super.key});

  @override
  State<AuthFinishLoadingView> createState() => _AuthFinishLoadingViewState();
}

class _AuthFinishLoadingViewState extends State<AuthFinishLoadingView> {
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  SpeakingRobot(
                    message: AuthStrings.readyToStartJourney,
                    robotImagePath: Assets.images.authRobotOpeningTheDoor.path,
                    messageShiftingRatio: 0.73,
                    spaceAfterMessage: 6,
                    robotWidth: (context.width * 0.55).clamp(150, 250),
                  ),
                  const Spacer(flex: 2),

                  const SequentialDotsLoading(),

                  const Spacer(flex: 1),
                ],
              ),
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
    // بنرسم مربع صغير ونلفه بزاوية 45 درجة عشان يدينا شكل الماسة/النجمة
    return const Icon(
      Icons.bolt,
      color: AppColors.accentYellow,
      size: 24,
    );
  }
}
