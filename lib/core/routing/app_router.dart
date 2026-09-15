import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volt/core/models/quiz_attempt/quiz_question_for_attempt_model.dart';
import 'package:volt/core/routing/routes.dart';
import 'package:volt/features/auth/presentation/views/auth_view.dart';
import 'package:volt/features/auth/presentation/views/login_view.dart';
import 'package:volt/features/auth/presentation/views/register_view.dart';
import 'package:volt/features/home/presentation/cubits/home_cubit.dart';
import 'package:volt/features/lessons/presentation1/cubits/lesson_content_cubit/lesson_content_cubit.dart';
import 'package:volt/features/lessons/presentation1/cubits/lesson_content_cubit/lesson_quiz_cubit/lesson_quiz_cubit.dart';
import 'package:volt/features/lessons/presentation1/views/lesson_content_view.dart';
import 'package:volt/features/lessons/presentation1/views/lesson_quiz_result_view.dart';
import 'package:volt/features/lessons/presentation1/views/lesson_quiz_view.dart';
import 'package:volt/features/main_layout/presentation/cubits/main_layout_cubit/main_layout_cubit.dart';
import 'package:volt/features/main_layout/presentation/views/main_layout_view.dart';
import 'package:volt/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:volt/features/quiz/presentation/views/quiz_initial_view.dart';
import 'package:volt/features/splash/presentation/views/splash_view.dart';

import '../di/service_locator.dart';
import '../storage/cache_helper.dart';
import '../storage/pref_keys.dart';

class LessonQuizRetryArgs {
  final List<QuizQuestionForAttemptModel> retryQuestions;
  final int attemptId;
  final int retryAttemptNumber;

  const LessonQuizRetryArgs({
    required this.retryQuestions,
    required this.attemptId,
    required this.retryAttemptNumber,
  });
}

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
      Routes.quiz => MaterialPageRoute(
        settings: settings,
        builder: (context) => const QuizInitialView(),
      ),
      Routes.mainLayout => MaterialPageRoute(
        settings: settings,
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<MainLayoutCubit>()),
            BlocProvider(
              create: (context) => sl<HomeCubit>()..getPublishedLessons(),
            ),
          ],
          child: const MainLayoutView(),
        ),
      ),
      Routes.lessonContent => MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final lessonId = (settings.arguments as int?) ?? 2;
          return BlocProvider(
            create: (context) => sl<LessonContentCubit>()..getLessonContents(lessonId: lessonId),
            child: const LessonContentView(),
          );
        },
      ),
      Routes.lessonQuiz => MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final lessonId = (settings.arguments as int?) ?? 1;
          return BlocProvider(
            create: (context) => sl<LessonQuizCubit>()..getLessonQuiz(lessonId: lessonId),
            child: const LessonQuizView(),
          );
        },
      ),
      Routes.lessonQuizResult => MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as LessonQuizResultArgs;
          return LessonQuizResultView(
            result: args.result,
            retryAttemptNumber: args.retryAttemptNumber,
          );
        },
      ),
      Routes.lessonQuizRetry => MaterialPageRoute(
        settings: settings,
        builder: (context) {
          final args = settings.arguments as LessonQuizRetryArgs;
          return BlocProvider(
            create: (context) {
              final cubit = sl<LessonQuizCubit>();
              cubit.startRetry(
                retryQuestions: args.retryQuestions,
                attemptId: args.attemptId,
              );
              return cubit;
            },
            child: LessonQuizView(retryAttemptNumber: args.retryAttemptNumber),
          );
        },
      ),
      _ => MaterialPageRoute(
        settings: settings,
        builder: (context) => const _UnknownScreen(),
      ),
    };
  }
}

class _UnknownScreen extends StatelessWidget {
  const _UnknownScreen() : routeName = 'unknown route';
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
