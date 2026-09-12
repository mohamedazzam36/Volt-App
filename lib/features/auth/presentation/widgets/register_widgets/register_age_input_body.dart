import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/extensions/ui_extension.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';
import 'package:volt/features/auth/presentation/widgets/register_widgets/custom_age_slider.dart';

class RegisterAgeInputBody extends StatefulWidget {
  final VoidCallback onNextStep;
  final ValueChanged<int> onAgeSelected;

  const RegisterAgeInputBody({
    super.key,
    required this.onNextStep,
    required this.onAgeSelected,
  });

  @override
  State<RegisterAgeInputBody> createState() => _RegisterAgeInputBodyState();
}

class _RegisterAgeInputBodyState extends State<RegisterAgeInputBody> {
  double _currentAge = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),

        Text(
          AuthStrings.howOldAreYou,
          style: AppStyles.bold24.responsive(context).copyWith(color: AppColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          AuthStrings.ageDescription,
          textAlign: TextAlign.center,
          style: AppStyles.medium14.responsive(context).copyWith(color: AppColors.textSecondary),
        ),

        const SizedBox(height: 48),

        Container(
          width: (context.width * 0.4).clamp(128, 200),
          height: (context.height * 0.4).clamp(128, 200),
          decoration: BoxDecoration(
            color: AppColors.surfaceGreenSoft,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.brandSecondaryGreen,
              width: 4.0,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            '${_currentAge.toInt()}',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900).responsive(context),
          ),
        ),

        const SizedBox(height: 48),

        CustomAgeSlider(
          currentAge: _currentAge,
          onChanged: (value) {
            setState(() {
              _currentAge = value;
            });
          },
        ),
        SizedBox(height: (context.height * 0.12).clamp(60, 100)),

        CustomElevatedButton(
          onTap: () {
            widget.onAgeSelected(_currentAge.toInt());
            widget.onNextStep();
          },
          text: CommonStrings.next,
          width: double.infinity,
          backgroundColor: AppColors.brandSecondaryGreen,
        ),

        const SizedBox(height: 16),
      ],
    );
  }
}
