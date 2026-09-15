import 'package:flutter/material.dart';


class LessonResultsView extends StatelessWidget {
  final String robotImagePath;
  final double percentage; 
  final int correctAnswers;
  final int incorrectAnswers;
  final int xpGained;
  final VoidCallback onRetryPressed;
  final VoidCallback onContinuePressed;
  final VoidCallback onEssayAnswersPressed;

  const LessonResultsView({
    super.key,
    required this.robotImagePath,
    required this.percentage,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.xpGained,
    required this.onRetryPressed,
    required this.onContinuePressed,
    required this.onEssayAnswersPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgroundLevel1.path'), // أو استخدام Assets.images... لو متوفرة عندك
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                // 1. مؤشر النسبة المئوية الدائري العلوي
                SizedBox(
                  width: screenWidth * 0.35,
                  height: screenWidth * 0.35,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: percentage / 100,
                        strokeWidth: 10,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "المجموع",
                            style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "%${percentage.toStringAsFixed(1)}",
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                // 2. كروت الإجابات الصحيحة والخاطئة
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatCard(
                      value: correctAnswers.toString(),
                      label: "اجابات صحيحة",
                      valueColor: const Color(0xFF2E7D32),
                      width: screenWidth * 0.38,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    _buildStatCard(
                      value: incorrectAnswers.toString(),
                      label: "اجابات خاطئة",
                      valueColor: const Color(0xFFD32F2F),
                      width: screenWidth * 0.38,
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.03),

                // 3. الروبوت ماسك الكأس + كارت الـ XP
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      robotImagePath,
                      height: screenWidth * 0.32,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "+$xpGained XP",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.04),

                // 4. أزرار التحكم (أعد المحاولة ومتابعة)
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: onRetryPressed,
                          child: const Text("اعد المحاولة", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2196F3),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: onContinuePressed,
                          child: const Text("متابعة", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: screenHeight * 0.015),

                // 5. زر عرض إجابات الأسئلة المقالية السفلي
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: onEssayAnswersPressed,
                    child: const Text("عرض اجابات الاسئلة المقالية", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({required String value, required String label, required Color valueColor, required double width}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: valueColor),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}