import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
import '../../../../../core/extensions/text_style_extension.dart';
import '../../../data/models/option_model.dart';

class TextChoiceQuizView extends StatelessWidget {
  final List<OptionModel> options;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;

  const TextChoiceQuizView({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedOptionId == option.id;

        return GestureDetector(
          onTap: () => onOptionSelected(option.id),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.surfaceSoftBlue : AppColors.surfaceDefault,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.brandPrimary : AppColors.borderDefault,
                width: isSelected ? 2.0 : 1.0,
              ),
            ),
            child: Text(
              option.text ?? '',
              textAlign: TextAlign.center,
              style: AppStyles.regular12
                  .responsive(context)
                  .copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                  ),
            ),
          ),
        );
      },
    );
  }
}
