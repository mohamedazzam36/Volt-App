import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class CustomOtpInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;
  final bool hasError;
  final bool showEmptyError;

  const CustomOtpInput({
    super.key,
    this.length = 6,
    this.onChanged,
    this.onCompleted,
    this.hasError = false,
    this.showEmptyError = false,
  });

  @override
  State<CustomOtpInput> createState() => _CustomOtpInputState();
}

class _CustomOtpInputState extends State<CustomOtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (index) => TextEditingController());
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();

        if (widget.onCompleted != null) {
          final otp = _controllers.map((e) => e.text).join();
          if (otp.length == widget.length) {
            widget.onCompleted!(otp);
          }
        }
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    if (widget.onChanged != null) {
      widget.onChanged!(_controllers.map((e) => e.text).join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: (context.width * 0.02).clamp(12, 20),
      textDirection: TextDirection.ltr,
      children: List.generate(widget.length, (index) {
        final isEmpty = _controllers[index].text.isEmpty;
        final isError = widget.hasError || (widget.showEmptyError && isEmpty);

        return SizedBox(
          width: (context.width * 0.1).clamp(50, 56),
          child: AspectRatio(
            aspectRatio: 0.91,
            child: TextFormField(
              expands: true,
              maxLines: null,
              minLines: null,
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
              maxLength: 1,
              style: AppStyles.semiBold18.responsive(context),
              decoration: InputDecoration(
                counterText: "",
                contentPadding: EdgeInsets.zero,
                filled: true,
                fillColor: isError ? AppColors.accentRed.withAlpha(60) : AppColors.surfaceDefault,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isError
                        ? AppColors.statusError
                        : AppColors.brandSecondaryBlue.withAlpha((255 * 0.3).toInt()),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: isError ? AppColors.statusError : AppColors.brandSecondaryBlue,
                    width: 1.5,
                  ),
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) => _onChanged(value, index),
            ),
          ),
        );
      }),
    );
  }
}
