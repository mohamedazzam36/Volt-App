import 'package:flutter/material.dart';
import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
import 'package:volt/features/onboarding/presentation/widgets/circle_image.dart';
import 'package:volt/features/onboarding/presentation/widgets/first_page_image.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_button.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:volt/features/onboarding/presentation/widgets/onboarding_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentIndex < OnboardingModel.pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentPage = OnboardingModel.pages[_currentIndex];

    final bool isDarkBackground = _currentIndex == 2;

    return Scaffold(
      backgroundColor: currentPage.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- HEADER ----------------
            OnboardingHeader(
              currentIndex: _currentIndex,
              onBackPressed: _previousPage,
              onLoginPressed: () {
                // Handle login button press
              },
            ),

            // ---------------- PAGE VIEW ----------------
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingModel.pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = OnboardingModel.pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Spacer(flex: 1),

                        // ---------------- IMAGE ----------------
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.35,
                          child: index == 0
                              ? FirstPageImage(
                                  imagePath: item.image,
                                )
                              : Image.asset(
                                  item.image,
                                  fit: BoxFit.contain,
                                ),
                        ),

                        const SizedBox(height: 16),

                        // ---------------- TITLE ----------------
                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: isDarkBackground
                                ? Colors.white
                                : const Color(0xFF1E293B),
                          ),
                        ),

                        const SizedBox(height: 6),

                        // ---------------- DESCRIPTION ----------------
                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkBackground
                                ? Colors.white70
                                : const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // ---------------- INDICATOR ----------------
                        OnboardingIndicator(
                          currentIndex: _currentIndex,
                          itemCount: OnboardingModel.pages.length,
                          activeColor: currentPage.buttonColor,
                        ),

                        const SizedBox(height: 18),

                        // ---------------- BUTTON ----------------
                        OnboardingButton(
                          text: currentPage.buttonText,
                          backgroundColor: currentPage.buttonColor,
                          onPressed: _nextPage,
                        ),

                        const Spacer(flex: 3),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}