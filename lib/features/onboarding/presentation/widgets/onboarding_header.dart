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
    final bool isDarkBackground = currentIndex == 2;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Login Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                left: BorderSide(
                  color: const Color(0xFFE2E8F0),
                  width: 2.5,
                ),
                right: BorderSide(
                  color: const Color(0xFFE2E8F0),
                  width: 2.5,
                ),
                bottom: BorderSide(
                  color: const Color(0xFFE2E8F0),
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

          // Back Arrow
          if (currentIndex > 0)
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: Icon(
                Icons.arrow_forward,
                size: 20,
                color: isDarkBackground ? Colors.white60 : Colors.black45,
              ),
              onPressed: onBackPressed,
            )
          else
            const SizedBox(width: 20),
        ],
      ),
    );
  }
}
