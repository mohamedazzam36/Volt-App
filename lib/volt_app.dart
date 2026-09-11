import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:volt/core/di/service_locator.dart';
import 'package:volt/core/routing/app_router.dart';
import 'package:volt/core/theme/app_theme.dart';
import 'package:volt/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthCubit>()..checkAuthStatus(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateInitialRoutes: (initialRoute) => [
          AppRouter.onGenerateRoute(RouteSettings(name: initialRoute))!,
        ],
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.initialRoute,
        theme: AppTheme.lightTheme,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale('ar'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) => MediaQuery.withClampedTextScaling(
          minScaleFactor: 0.7,
          maxScaleFactor: 1.3,
          child: child!,
        ),
      ),
    );
  }
}
