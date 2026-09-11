import 'package:flutter/material.dart';

import '../../../../../core/extensions/text_style_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../data/models/option_model.dart';

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
    final selected = _selectedOption;

    return Column(
      children: [
        // كارت السؤال الرئيسي
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: AppColors.surfaceDefault,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderSubtle, width: 1.2),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                'يقاس الجهد الكهربائي بوحدة',
                textDirection: TextDirection.rtl,
                style: AppStyles.semiBold16
                    .responsive(context)
                    .copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(width: 10),
              // مكان الفراغ / الكلمة المختارة
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
                    textDirection: TextDirection.rtl,
                    style: AppStyles.semiBold16
                        .responsive(context)
                        .copyWith(
                          color: AppColors.brandPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 28),

        // خيارات الكلمات (Chips)
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: options.map((option) {
            final isSelected = selectedOptionId == option.id;

            // إذا كانت الكلمة مختارة، تخفيها من الخيارات السفلية مثل ديزاين Figma
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
                  textDirection: TextDirection.rtl,
                  style: AppStyles.semiBold16
                      .responsive(context)
                      .copyWith(
                        color: AppColors.brandPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  OptionModel? get _selectedOption {
    for (final option in options) {
      if (option.id == selectedOptionId) return option;
    }
    return null;
  }
}
