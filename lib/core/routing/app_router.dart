import 'package:flutter/material.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/auth/presentation/views/auth_view.dart';
import 'package:volt/features/auth/presentation/views/login_view.dart';
import 'package:volt/features/auth/presentation/views/register_view.dart';
import 'package:volt/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:volt/features/splash/presentation/views/splash_view.dart';

import '../di/service_locator.dart';
import '../storage/cache_helper.dart';
import '../storage/pref_keys.dart';

class AppRouter {
  static const initialRoute = Routes.splash;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.splash => MaterialPageRoute(
        settings: settings,
        builder: (context) => SplashView(
          isOnboardingViewed: sl<CacheHelper>().getBool(PrefKeys.isOnboardingViewed) ?? false,
        ),
      ),
      Routes.onboarding => MaterialPageRoute(
        settings: settings,
        builder: (context) => const OnboardingView(),
      ),
      Routes.auth => MaterialPageRoute(
        settings: settings,
        builder: (context) => const AuthView(),
      ),
      Routes.login => MaterialPageRoute(
        settings: settings,
        builder: (context) => const LoginView(),
      ),
      Routes.register => MaterialPageRoute(
        settings: settings,
        builder: (context) => const RegisterView(),
      ),
      Routes.home => MaterialPageRoute(
        settings: settings,
        builder: (context) => const _UnknownScreen(
          routeName: "home",
        ),
      ),
      _ => MaterialPageRoute(
        settings: settings,
        builder: (context) => const _UnknownScreen(),
      ),
    };
  }
}

class _UnknownScreen extends StatelessWidget {
  const _UnknownScreen({this.routeName = 'unknown route'});
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(routeName),
      ),
    );
  }
}
