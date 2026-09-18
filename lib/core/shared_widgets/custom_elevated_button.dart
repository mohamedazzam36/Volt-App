import 'package:flutter/material.dart';
import '../extensions/text_style_extension.dart';
import '../extensions/ui_extension.dart';
import '../theme/app_styles.dart';

import '../theme/app_colors.dart';

class CustomElevatedButton extends StatefulWidget {
  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.width,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final Color? backgroundColor, textColor;

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  double bottomBorder = 4;

  void _pressDown() => setState(() => bottomBorder = 1);

  void _releaseUp() => setState(() => bottomBorder = 4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: widget.width ?? (context.width * 0.85).clamp(200, 600),
      child: GestureDetector(
        onTapDown: (_) {
          _pressDown();
        },
        onTapUp: (_) {
          _releaseUp();
          widget.onTap?.call();
        },
        onTapCancel: _releaseUp,
        child: Container(
          decoration: BoxDecoration(
            color: Color.lerp(widget.backgroundColor ?? AppColors.brandPrimary, Colors.black, 0.25),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            margin: EdgeInsets.only(bottom: bottomBorder),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? AppColors.brandPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.text,
              style: AppStyles.extraBold14
                  .responsive(context)
                  .copyWith(color: widget.textColor ?? AppColors.textOnBrand),
            ),
          ),
        ),
      ),
    );
  }
}
