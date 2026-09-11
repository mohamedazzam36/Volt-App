import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(start: 4),
          child: Text(
            AuthStrings.forgotPassword,
            style: AppStyles.semiBold14
                .responsive(context)
                .copyWith(color: AppColors.brandSecondaryBlue),
          ),
        ),
      ),
    );
  }
}
