import 'package:flutter/material.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_body.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_header/auth_header.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/auth_scrollable_body.dart';

class AuthViewBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScrollableBody(
      padding: EdgeInsets.all(0),
      child: Column(
        spacing: 8,
        children: [
          AuthHeader(),
          Expanded(
            child: Center(child: AuthBody()),
          ),
        ],
      ),
    );
  }
}
