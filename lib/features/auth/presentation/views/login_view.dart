import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

import '../widgets/login_widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.surfaceYellowSoft,
      body: LoginViewBody(),
    );
  }
}
