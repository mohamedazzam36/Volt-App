import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class HelpButton extends StatefulWidget {
  final VoidCallback onTap;

  const HelpButton({super.key, required this.onTap});

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  double _bottom = 3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _bottom = 0),
      onTapUp: (_) {
        setState(() => _bottom = 3);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _bottom = 3),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.brandPrimary.withAlpha(80),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: _bottom),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            LessonStrings.help,
            style: AppStyles.bold14.copyWith(color: AppColors.textOnBrand),
          ),
        ),
      ),
    );
  }
}
