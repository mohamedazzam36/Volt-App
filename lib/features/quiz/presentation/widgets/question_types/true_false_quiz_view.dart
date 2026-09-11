import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

import '../../../../../core/constants/app_strings.dart';

class TrueFalseQuizView extends StatelessWidget {
  final bool? selectedValue;
  final ValueChanged<bool> onValueSelected;

  const TrueFalseQuizView({
    super.key,
    required this.selectedValue,
    required this.onValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        // خيار صح (يمين)
        Expanded(
          child: _buildChoiceCard(
            label: QuizStrings.trueOption,
            isSelected: selectedValue == true,
            activeColor: AppColors.accentGreen,
            backgroundColor: AppColors.surfaceGreenSoft,
            bottomShadowColor: AppColors.statusSuccess,
            icon: Icons.check,
            onTap: () => onValueSelected(true),
          ),
        ),
        const SizedBox(width: 12),
        // خيار خطأ (شمال)
        Expanded(
          child: _buildChoiceCard(
            label: QuizStrings.falseOption,
            isSelected: selectedValue == false,
            activeColor: AppColors.accentRed,
            backgroundColor: AppColors.surfaceOrangeSoft,
            bottomShadowColor: AppColors.statusError,
            icon: Icons.close,
            onTap: () => onValueSelected(false),
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceCard({
    required String label,
    required bool isSelected,
    required Color activeColor,
    required Color backgroundColor,
    required Color bottomShadowColor,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 78,
        decoration: BoxDecoration(
          color: isSelected ? bottomShadowColor : activeColor.withAlpha(50),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: isSelected ? 5.0 : 0.0), // تأثير ارتفاع الـ 3D
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: activeColor,
              width: isSelected ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الدائرة الملونة بالأيقونة
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: activeColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppColors.textOnBrand,
                  size: 16,
                ),
              ),
              const SizedBox(height: 4),
              // النص
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: activeColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
