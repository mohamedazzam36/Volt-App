import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class EssayQuestionWidget extends StatelessWidget {
  final String essayText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmit;

  const EssayQuestionWidget({
    super.key,
    required this.essayText,
    required this.onChanged,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceSoftBlue,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: essayText.isNotEmpty ? AppColors.brandPrimary : AppColors.borderSubtle,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: TextField(
            onChanged: onChanged,
            maxLines: 4,
            minLines: 3,
            textAlign: TextAlign.end,
            textDirection: TextDirection.rtl,
            style: AppStyles.regular14.responsive(context).copyWith(color: AppColors.textPrimary),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'اكتب إجابتك هنا...',
              hintStyle: AppStyles.regular14
                  .responsive(context)
                  .copyWith(color: AppColors.textTertiary),
            ),
          ),
        ),

        _SubmitButton(
          isEnabled: essayText.trim().isNotEmpty,
          onTap: onSubmit,
        ),
      ],
    );
  }
}

class _SubmitButton extends StatefulWidget {
  final bool isEnabled;
  final VoidCallback? onTap;

  const _SubmitButton({required this.isEnabled, this.onTap});

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  double _bottomBorder = 4;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isEnabled ? AppColors.neutralSlate : AppColors.borderSubtle;

    return GestureDetector(
      onTapDown: widget.isEnabled ? (_) => setState(() => _bottomBorder = 1) : null,
      onTapUp: widget.isEnabled
          ? (_) {
              setState(() => _bottomBorder = 4);
              widget.onTap?.call();
            }
          : null,
      onTapCancel: () => setState(() => _bottomBorder = 4),
      child: SizedBox(
        height: 54,
        child: Container(
          decoration: BoxDecoration(
            color: Color.lerp(bgColor, Colors.black, 0.25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: _bottomBorder),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              'إرسال',
              style: AppStyles.extraBold14
                  .responsive(context)
                  .copyWith(
                    color: widget.isEnabled ? AppColors.textOnBrand : AppColors.textDisabled,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
