import 'package:flutter/material.dart';

import '../../../../../core/extensions/text_style_extension.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_styles.dart';
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

  String _getOptionLetter(int index) {
    return String.fromCharCode(65 + index);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: options.length,
      separatorBuilder: (_, _) => SizedBox(height: screenWidth * 0.025),
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedOptionId == option.id;

        return GestureDetector(
          onTap: () => onOptionSelected(option.id),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 56),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.surfaceBlueSoft : AppColors.surfaceDefault,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.brandPrimary : AppColors.textDisabled,
                width: isSelected ? 1.15 : 1.0,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.brandPrimary : AppColors.textDisabled,
                      width: isSelected ? 6.0 : 2.0,
                    ),
                    color: AppColors.surfaceDefault,
                  ),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      option.text ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: (isSelected ? AppStyles.bold12 : AppStyles.medium12)
                          .responsive(context)
                          .copyWith(
                            color: isSelected ? AppColors.brandPrimary : AppColors.textPrimary,
                          ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24,
                  child: Text(
                    '.${_getOptionLetter(index)}',
                    style: AppStyles.bold12
                        .responsive(context)
                        .copyWith(
                          color: isSelected ? AppColors.brandPrimary : AppColors.textDisabled,
                        ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
