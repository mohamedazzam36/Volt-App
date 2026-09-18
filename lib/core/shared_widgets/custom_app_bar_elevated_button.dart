import 'package:flutter/material.dart';
import '../extensions/text_style_extension.dart';
import '../theme/app_styles.dart';

import '../theme/app_colors.dart';

class CustomAppBarElevatedButton extends StatefulWidget {
  const CustomAppBarElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor = AppColors.surfaceDefault,
    this.borderColor = AppColors.borderSubtle,
    this.textColor = AppColors.brandPrimary,
  });

  final VoidCallback onTap;
  final String text;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  @override
  State<CustomAppBarElevatedButton> createState() => _CustomAppBarElevatedButtonState();
}

class _CustomAppBarElevatedButtonState extends State<CustomAppBarElevatedButton> {
  double bottomBorder = 4;

  void _pressDown() => setState(() => bottomBorder = 2);
  void _releaseUp() => setState(() => bottomBorder = 4);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: GestureDetector(
        onTapDown: (_) => _pressDown(),
        onTapUp: (_) {
          _releaseUp();
          widget.onTap();
        },
        onTapCancel: _releaseUp,
        child: Container(
          decoration: BoxDecoration(
            color: widget.borderColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Container(
            margin: EdgeInsets.only(
              top: 1.2,
              bottom: bottomBorder,
              left: 1.8,
              right: 1.8,
            ),
            padding: const EdgeInsets.only(left: 14, right: 14, top: 6),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              widget.text,
              style: AppStyles.black12.responsive(context).copyWith(color: widget.textColor),
            ),
          ),
        ),
      ),
    );
  }
}
