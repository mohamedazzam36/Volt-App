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
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.15, // ضُبطت النسبة لتعطي ارتفاع متناسق للكروت
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
