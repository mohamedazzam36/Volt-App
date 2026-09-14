import 'package:flutter/material.dart';

import '../../../../../core/constants/app_strings.dart';
import '../../../../../core/extensions/text_style_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';

/// ويدجت عرض أسئلة صح أم خطأ (True / False Quiz View)

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
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Row(
      children: [
        // خيار صح
        Expanded(
          child: _buildChoiceCard(
            context: context,
            label: QuizStrings.trueOption,
            isSelected: selectedValue == true,
            activeColor: AppColors.accentGreen,
            backgroundColor: AppColors.surfaceGreenSoft,
            bottomShadowColor: AppColors.statusSuccess,
            icon: Icons.check,
            onTap: () => onValueSelected(true),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        // خيار خطأ
        Expanded(
          child: _buildChoiceCard(
            context: context,
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

  /// بناء كارت الاختيار بخلفية 3D متجاوبة
  Widget _buildChoiceCard({
    required BuildContext context,
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        constraints: const BoxConstraints(minHeight: 76),
        decoration: BoxDecoration(
          color: isSelected ? bottomShadowColor : activeColor.withAlpha(50),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          // إنشاء تأثير الـ 3D عبر إزاحة المرجن عند التحديد
          margin: EdgeInsets.only(bottom: isSelected ? 4.0 : 0.0),
          padding: const EdgeInsets.symmetric(vertical: 12),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              // دائرة الأيقونة
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
              const SizedBox(height: 6),
              // نص الخيار
              Text(
                label,
                style: AppStyles.bold12
                    .responsive(context)
                    .copyWith(
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
