import 'package:flutter/material.dart';

import '../../../data/models/option_model.dart';
import '../image_option_card.dart';

class ImageChoiceQuizView extends StatelessWidget {
  final List<OptionModel> options;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;

  const ImageChoiceQuizView({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    // حساب نسبة أبعاد الكارت بناءً على عرض الشاشة لضمان تجاوب الـ Grid
    final childAspectRatio = screenWidth < 360 ? 1.0 : 1.12;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: screenWidth * 0.03, // مسافة متجاوبة بين العواميد
        mainAxisSpacing: screenWidth * 0.03,  // مسافة متجاوبة بين الصفوف
        childAspectRatio: childAspectRatio,
      ),
      itemCount: options.length,
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = selectedOptionId == option.id;

        return ImageOptionCard(
          imageUrl: option.imageUrl ?? '',
          isSelected: isSelected,
          onTap: () => onOptionSelected(option.id),
        );
      },
    );
  }
}
