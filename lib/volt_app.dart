import 'package:flutter/material.dart';
import 'package:volt/core/constants/fonts.gen.dart';
import 'package:volt/core/routing/app_router.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.initialRoute,
      theme: ThemeData(fontFamily: FontFamily.cairo),
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 0.7,
        maxScaleFactor: 1.3,
        child: child!,
      ),
    );
  }
}
