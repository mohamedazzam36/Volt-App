import 'package:flutter/material.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class StatCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final double width;
  final double? height;

  const StatCardWidget({
    super.key,
    required this.value,
    required this.label,
    required this.valueColor,
    required this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height ?? screenHeight * 0.13,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.015,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceDefault,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.5,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    style: AppStyles.bold32.responsive(context).copyWith(
                      color: valueColor,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: AppStyles.bold12.responsive(context).copyWith(
                      color: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
