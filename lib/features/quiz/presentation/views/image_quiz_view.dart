import 'package:flutter/material.dart';
import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/shared_widgets/custom_elevated_button.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/quiz/presentation/widgets/image_option_card.dart';
import 'package:volt/features/quiz/presentation/widgets/quiz_question_section.dart';
import '../../data/models/option_model.dart';

class ImageQuizView extends StatelessWidget {
  final String questionText;
  final List<OptionModel> options;
  final String? selectedOptionId;
  final ValueChanged<String> onOptionSelected;
  final VoidCallback onCheckPressed;

  const ImageQuizView({
    super.key,
    required this.questionText,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
    required this.onCheckPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isButtonActive = selectedOptionId != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          // 1. الروبوت والفقاعة
          QuizQuestionSection(
            message: questionText,
          ),

          const SizedBox(height: 16),

          // 2. شبكة خيارات الصور (2x2)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = selectedOptionId == option.id;

              return ImageOptionCard(
                imageUrl: option.imageUrl ?? '',
                isSelected: isSelected,
                onTap: () => onOptionSelected(option.id),
              );
            },
          ),

          const SizedBox(height: 24),

          // 3. زر الإرسال الموحد
          CustomElevatedButton(
            text: CommonStrings.sent,
            color: isButtonActive
                ? AppColors.brandPrimary
                : AppColors.borderDefault,
            textColor: AppColors.textOnBrand,
            onTap: isButtonActive ? onCheckPressed : null,
          ),
        ],
      ),
    );
  }
}