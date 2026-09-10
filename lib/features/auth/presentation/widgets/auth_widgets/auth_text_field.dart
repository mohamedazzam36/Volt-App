import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/widgets/auth_widgets/custom_error_text.dart';

// متنساش تعمل import للـ CustomErrorText لو حطيتها في فايل تاني

class AuthTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final bool isValid;
  final String? errorText;
  final bool isPassword;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool? obscureText; // عشان نجبره ياخد حالة الإخفاء من بره لو حبينا
  final VoidCallback? onVisibilityToggle;

  // 1. الديفولت كونستراكتور
  const AuthTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.hintText,
    this.isValid = false,
    this.errorText,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.obscureText,
    this.onVisibilityToggle,
  });

  // 2. Named Constructor للإيميل
  // 2. Named Constructor للإيميل
  const AuthTextField.email({
    super.key,
    this.controller,
    this.labelText = AuthStrings.emailLabel,
    this.hintText = AuthStrings.emailHint,
    this.isValid = false,
    this.errorText,
    this.onChanged,
    this.obscureText,
    this.onVisibilityToggle,
    this.validator,
  }) : isPassword = false,
       keyboardType = TextInputType.emailAddress;

  // 3. Named Constructor للباسورد
  const AuthTextField.password({
    super.key,
    this.controller,
    this.labelText = 'كلمة المرور',
    this.hintText = '••••••••',
    this.errorText,
    this.onChanged,
    this.obscureText,
    this.onVisibilityToggle,
    this.validator,
  }) : isPassword = true,
       isValid = false,
       keyboardType = TextInputType.visiblePassword;

  // 4. Named Constructor للاسم
  const AuthTextField.name({
    super.key,
    this.controller,
    this.obscureText,
    this.onVisibilityToggle,
    this.labelText = 'الاسم',
    this.hintText = 'مثال: محمد عزام',
    this.isValid = false,
    this.errorText,
    this.onChanged,
    this.validator,
  }) : isPassword = false,
       keyboardType = TextInputType.name;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 4),
          child: Text(
            widget.labelText,
            style: AppStyles.bold16.responsive(context),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText ?? _obscureText,
          cursorHeight: 18,
          textDirection: (widget.isPassword || widget.keyboardType == TextInputType.emailAddress)
              ? TextDirection.ltr
              : null,
          textAlign: TextAlign.start,
          style: AppStyles.medium16.responsive(context),
          decoration: InputDecoration(
            filled: true,
            fillColor: hasError
                ? AppColors.statusError.withValues(alpha: 0.06)
                : (widget.isValid ? AppColors.surfaceBlueSoft : AppColors.surfaceSubtle),
            hintText: widget.hintText,
            hintTextDirection: TextDirection.ltr,
            hintStyle: AppStyles.semiBold18
                .responsive(context)
                .copyWith(color: AppColors.textSecondary),
            prefixIcon: widget.isValid && !hasError
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(
                      Icons.check_circle,
                      color: AppColors.brandSecondaryBlue,
                      size: 20,
                    ),
                  )
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      (widget.obscureText ?? _obscureText)
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.iconSecondary,
                      size: 22,
                    ),
                    onPressed: () {
                      if (widget.onVisibilityToggle != null) {
                        widget.onVisibilityToggle!();
                      } else {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      }
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: hasError
                    ? AppColors.statusError
                    : (widget.isValid ? AppColors.brandSecondaryBlue : AppColors.borderSubtle),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: hasError ? AppColors.statusError : AppColors.brandSecondaryBlue,
                width: 1.8,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.statusError, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.statusError, width: 1.8),
            ),
            errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          ),
        ),
        if (hasError) CustomErrorText(errorText: widget.errorText!),
      ],
    );
  }
}
