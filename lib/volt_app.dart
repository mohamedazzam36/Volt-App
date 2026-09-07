import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volt/core/routing/app_router.dart';

class VoltApp extends StatelessWidget {
  const VoltApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.initialRoute,
      theme: ThemeData(fontFamily: GoogleFonts.cairo().fontFamily),
    );
  }
}
