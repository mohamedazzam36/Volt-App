import 'package:flutter/material.dart';
import 'package:volt/core/theme/app_colors.dart';

class LessonHelpButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double height;

  const LessonHelpButton({
    super.key,
    required this.onTap,
    this.text = 'مساعدة',
    this.width,
    this.height = 36,
  });

  @override
  State<LessonHelpButton> createState() => _LessonHelpButtonState();
}

class _LessonHelpButtonState extends State<LessonHelpButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        width: widget.width,
        height: widget.height,
        // لما يضغط بننزل الزرار لتحت شوية ونقلل الظل عشان يبان إنه اتضغط للداخل
        margin: EdgeInsets.only(top: _isPressed ? 4 : 0),
        decoration: BoxDecoration(
          color: AppColors.brandPrimary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandPrimaryPressed,
              // لما يضغط بيختفي الظل السفلي أو يقل عشان يبان إنه استقر في الأرض
              offset: Offset(0, _isPressed ? 0 : 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.text,
          style: const TextStyle(
            color: AppColors.textOnBrand,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
