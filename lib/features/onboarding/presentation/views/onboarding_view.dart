import 'package:flutter/material.dart';

import 'package:volt/features/onboarding/dataa/models/onboarding_model.dart';
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

  // ============================================================
  // PAGE NAVIGATION
  // ============================================================

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final screenWidth = size.width;
    final screenHeight = size.height;

    final currentPage = OnboardingModel.pages[_currentIndex];
    final isDarkBackground = _currentIndex == 2;


    final horizontalPadding = (screenWidth * 0.055).clamp(
      16.0,
      28.0,
    );

  
    final contentHeight = (screenHeight * 0.59).clamp(
      350.0,
      445.0,
    );

    return Scaffold(
      backgroundColor: currentPage.backgroundColor,

      body: SafeArea(
        child: Column(
          children: [
            // ========================================================
            // HEADER
            // ========================================================

            SizedBox(
              height: 48,
              width: double.infinity,
              child: OnboardingHeader(
                currentIndex: _currentIndex,
                onBackPressed: _previousPage,
                onLoginPressed: () {
                  // TODO: Handle login
                },
              ),
            ),


            const SizedBox(height: 60),

        

            SizedBox(
              height: contentHeight,
              width: double.infinity,

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

                  final itemIsDarkBackground = index == 2;

                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),

                    child: Column(
                      children: [
                        // ==================================================
                        // IMAGE
                        // ==================================================

                        SizedBox(
                          height: contentHeight * 0.68,
                          width: double.infinity,

                          child: index == 0
                              ? FirstPageImage(
                                  imagePath: item.image,
                                )
                              : Image.asset(
                                  item.image,
                                  fit: BoxFit.contain,
                                ),
                        ),

                        // ==================================================
                        // TITLE
                        // ==================================================

                        SizedBox(
                          height: contentHeight * 0.13,
                          width: double.infinity,

                          child: Center(
                            child: Text(
                              item.title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: (screenWidth * 0.058).clamp(
                                  20.0,
                                  25.0,
                                ),
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                                color: itemIsDarkBackground
                                    ? Colors.white
                                    : const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                        ),

                        // ==================================================
                        // DESCRIPTION
                        // ==================================================

                        SizedBox(
                          height: contentHeight * 0.04,
                          width: double.infinity,

                          child: Center(
                            child: Text(
                              item.description,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                fontSize: (screenWidth * 0.033).clamp(
                                  12.0,
                                  14.0,
                                ),
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                                color: itemIsDarkBackground
                                    ? Colors.white70
                                    : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // ============================================================
            // INDICATOR
            // ============================================================

            SizedBox(
              height: 8,
              child: Center(
                child: OnboardingIndicator(
                  currentIndex: _currentIndex,
                  itemCount: OnboardingModel.pages.length,
                  activeColor: currentPage.buttonColor,
                ),
              ),
            ),

            // ============================================================
            // SMALL SPACE
            // ============================================================

            const SizedBox(height: 8),

            // ============================================================
            // BUTTON
            // ============================================================

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),

              child: SizedBox(
                width: double.infinity,

                height: (screenHeight * 0.058).clamp(
                  38.0,
                  48.0,
                ),

                child: OnboardingButton(
                  text: currentPage.buttonText,
                  backgroundColor: currentPage.buttonColor,
                  onPressed: _nextPage,
                ),
              ),
            ),

            // ============================================================
            // BOTTOM SPACE
            // ============================================================

            const Spacer(),
          ],
        ),
      ),
    );
  }
}



