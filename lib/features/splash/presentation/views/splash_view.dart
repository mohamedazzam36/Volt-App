import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/navigation_extension.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/core/theme/app_styles.dart';

import '../widgets/loading_bar.dart';
import '../widgets/speech_bubble.dart';

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
      context.pushReplacementNamed(Routes.onboarding, arguments: 222);
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
              Color(0xFF33B5FF),
              Color(0xFFE8F7FF),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            const SpeechBubble(text: 'يلا نشحن طاقة تعلّمك!'),
            const SizedBox(height: 10),
            Image.asset(
              Assets.images.rasingLeftHandRobot.path,
              height: 220,
            ),
            const SizedBox(height: 20),
            const Text('فولت', style: AppStyles.regular12),
            const Text(
              'by CTRL-Z',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                letterSpacing: 1.1,
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
