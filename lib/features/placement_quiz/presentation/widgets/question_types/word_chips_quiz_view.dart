import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';

import '../../../../../core/extensions/text_style_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../data/models/option_model.dart';

/// ويدجت عرض أسئلة الكلمات التفاعلية (Word Chips)
/// تقوم بعرض نص السؤال الرئيسي مع مكان الفراغ أو الكلمة المختارة،
/// وتوفر قائمة الخيارات كـ Chips مجاورة للضغط عليها.
class WordChipsQuizView extends StatelessWidget {
  final List<OptionModel> options;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;

  const WordChipsQuizView({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final selected = _selectedOption;

    return Column(
      children: [
        // كارت السؤال الرئيسي مع مكان الفراغ / الإجابة
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceDefault,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.textDisabled, width: 1.2),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown, // حماية الجملة من الـ Overflow في الشاشات الصغيرة
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  QuizStrings.voltageIsMeasuredIn,
                  maxLines: 1,
                  style: AppStyles.regular16
                      .responsive(context)
                      .copyWith(
                        color: AppColors.textPrimary,
                        
                      ),
                ),
                const SizedBox(width: 10),

                // حالة عدم الاختيار: عرض خط الفراغ السفلي
                if (selected == null)
                  Container(
                    width: 100,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.brandPrimary,
                          width: 1.15,
                        ),
                      ),
                    ),
                    child: const SizedBox(height: 24),
                  )
                // حالة اختيار كلمة: عرض الكلمة داخل Chip مضاء في الفراغ
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSoftBlue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.brandPrimary,
                        width: 1.2,
                      ),
                    ),
                    child: Text(
                      selected.text ?? '',
                      maxLines: 1,
                      style: AppStyles.semiBold16
                          .responsive(context)
                          .copyWith(
                            color: AppColors.textPrimary,
                          ),
                    ),
                  ),
              ],
            ),
          ),
        ),

        SizedBox(height: screenWidth * 0.07),

        // قائمة الكلمات المتاحة (Word Chips)
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: options.map((option) {
            final isSelected = selectedOptionId == option.id;

            // إخفاء الكلمة من الخيارات السفلية عند تحديدها للتعويض في الفراغ العلوي
            if (isSelected) {
              return const SizedBox.shrink();
            }

            return GestureDetector(
              onTap: () => onOptionSelected(option.id),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDefault,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.brandPrimary,
                    width: 1.2,
                  ),
                ),
                child: Text(
                  option.text ?? '',
                  style: AppStyles.semiBold16
                      .responsive(context)
                      .copyWith(
                        color: AppColors.textPrimary
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// إرجاع الكائن المحدد بناءً على الـ ID الحالي
  OptionModel? get _selectedOption {
    for (final option in options) {
      if (option.id == selectedOptionId) return option;
    }
    return null;
  }
}
