import 'package:flutter/material.dart';

import '../../extensions/text_style_extension.dart';
import '../../models/quiz_attempt/quiz_answer_option_model.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';

class TrueFalseQuestionWidget extends StatelessWidget {
  final List<QuizAnswerOptionModel> options;
  final int? selectedOptionId;
  final ValueChanged<int> onSelect;

  const TrueFalseQuestionWidget({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = [...options]..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16,
      children: [
        for (int i = 0; i < sorted.length; i++)
          _TrueFalseButton(
            label: sorted[i].optionText ?? '',
            icon: i == 0 ? Icons.check_rounded : Icons.close_rounded,
            isTrue: i == 0,
            isSelected: selectedOptionId == sorted[i].optionId,
            onTap: () => onSelect(sorted[i].optionId),
          ),
      ],
    );
  }
}

class _TrueFalseButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isTrue;
  final bool isSelected;
  final VoidCallback onTap;

  const _TrueFalseButton({
    required this.label,
    required this.icon,
    required this.isTrue,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_TrueFalseButton> createState() => _TrueFalseButtonState();
}

class _TrueFalseButtonState extends State<_TrueFalseButton> {
  double _scale = 1.0;

  Color get _bgColor => widget.isTrue ? AppColors.surfaceGreenSoft : const Color(0xFFFFEBEB);

  Color get _iconColor => widget.isTrue ? AppColors.statusSuccess : AppColors.statusError;

  Color get _borderColor => widget.isSelected
      ? (widget.isTrue ? AppColors.statusSuccess : AppColors.statusError)
      : AppColors.borderDefault;

  Color get _shadowColor =>
      widget.isTrue ? AppColors.statusSuccess.withAlpha(80) : AppColors.statusError.withAlpha(80);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.95),
      onTapUp: (_) {
        setState(() => _scale = 1.0);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _scale = 1.0),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 130,
          height: 90,
          decoration: BoxDecoration(
            color: _bgColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _borderColor,
              width: widget.isSelected ? 2.5 : 1.5,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: _shadowColor,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: widget.isSelected ? _iconColor : _iconColor.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  color: widget.isSelected ? Colors.white : _iconColor,
                  size: 20,
                ),
              ),
              Text(
                widget.label,
                style: AppStyles.extraBold14.responsive(context).copyWith(color: _iconColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
