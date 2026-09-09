import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onBackPressed;
  final VoidCallback onLoginPressed;

  const OnboardingHeader({
    super.key,
    required this.currentIndex,
    required this.onBackPressed,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 4,
      ),
      child: Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: const Border(
              top: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1.5,
              ),
              left: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 2.5,
              ),
              right: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 2.5,
              ),
              bottom: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 4,
              ),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: onLoginPressed,
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                'دخول',
                style: TextStyle(
                  color: Color(0xFF2CA8FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
