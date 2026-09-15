import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/models/quiz_attempt/quiz_answer_option_model.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class MultipleChoiceQuestionWidget extends StatelessWidget {
  final List<QuizAnswerOptionModel> options;
  final int? selectedOptionId;
  final ValueChanged<int> onSelect;

  const MultipleChoiceQuestionWidget({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onSelect,
  });

  static const _labels = ['A', 'B', 'C', 'D', 'E'];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        for (int i = 0; i < options.length; i++)
          _MCQOptionTile(
            label: i < _labels.length ? _labels[i] : '${i + 1}',
            optionText: options[i].optionText ?? '',
            isSelected: selectedOptionId == options[i].optionId,
            onTap: () => onSelect(options[i].optionId),
          ),
      ],
    );
  }
}

class _MCQOptionTile extends StatefulWidget {
  final String label;
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const _MCQOptionTile({
    required this.label,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_MCQOptionTile> createState() => _MCQOptionTileState();
}

class _MCQOptionTileState extends State<_MCQOptionTile> {
  bool _pressed = false;

  Color get _borderColor => widget.isSelected ? AppColors.brandPrimary : AppColors.borderDefault;

  Color get _bgColor => widget.isSelected ? AppColors.surfaceSoftBlue : AppColors.surfaceDefault;

  Color get _labelBgColor => widget.isSelected ? AppColors.brandPrimary : AppColors.borderSubtle;

  Color get _labelTextColor => widget.isSelected ? AppColors.textOnBrand : AppColors.textSecondary;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _borderColor,
              width: widget.isSelected ? 2 : 1.5,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppColors.brandPrimary.withAlpha(50),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: _labelBgColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.label,
                  style: AppStyles.bold12.responsive(context).copyWith(color: _labelTextColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.optionText,
                  style: AppStyles.semiBold14
                      .responsive(context)
                      .copyWith(
                        color: widget.isSelected ? AppColors.textPrimary : AppColors.textPrimary,
                      ),
                  textAlign: TextAlign.end,
                ),
              ),
              const SizedBox(width: 8),

              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _borderColor,
                    width: widget.isSelected ? 6 : 2,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
