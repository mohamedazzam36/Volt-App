import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/auth/presentation/views/auth_view.dart';
import 'package:volt/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:volt/features/quiz/data/repositories/quiz_repository.dart';
import 'package:volt/features/quiz/presentation/cubits/quiz_cubit.dart';
import 'package:volt/features/quiz/presentation/views/quiz_screen.dart';
import 'package:volt/features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const initialRoute = Routes.home;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return switch (settings.name) {
      Routes.splash => MaterialPageRoute(
        builder: (context) => const SplashView(),
      ),
      Routes.onboarding => MaterialPageRoute(
        builder: (context) => const OnboardingView(),
      ),
      Routes.auth => MaterialPageRoute(
        builder: (context) => const AuthView(),
      ),
      Routes.home => MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (_) => QuizCubit(QuizRepository())..loadQuestions(),
          child: const QuizScreen(),
        ),
      ),
      _ => MaterialPageRoute(
        builder: (context) => const _UnknownScreen(),
      ),
    };
  }
}

class _UnknownScreen extends StatelessWidget {
  const _UnknownScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Unknown route'),
      ),
    );
  }
}
