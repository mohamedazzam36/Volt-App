import 'package:flutter/material.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/core/extensions/text_style_extension.dart';
import 'package:volt/core/shared_widgets/speaking_robot.dart';
import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/core/theme/app_styles.dart';

class QuizQuestionSection extends StatelessWidget {
  final String message;
  final int currentQuestionIndex;

  const QuizQuestionSection({
    super.key,
    required this.message,
    required this.currentQuestionIndex,
  });

  bool get _isLayoutShifted => currentQuestionIndex > 2;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    final screenWidth = mediaQuery.width;
    final screenHeight = mediaQuery.height;

    // أبعاد متجاوبة بناءً على حجم الشاشة
    final robotWidth = screenWidth * 0.28;
    final responsiveVerticalSpacing = screenHeight * 0.055; // نسبة متجاوبة للمسافة الرأسية
    final defaultSpaceAfterMessage = screenHeight * 0.045;

    final messageStyle = AppStyles.semiBold14
        .responsive(context)
        .copyWith(
          color: AppColors.textPrimary,
        );

    // الوضع التلقائي لأول سؤالين
    if (!_isLayoutShifted) {
      return DefaultTextStyle(
        style: messageStyle,
        child: SpeakingRobot(
          message: message,
          robotImagePath: Assets.images.greenRobotThinking.path,
          isMessageOneLine: true,
          messageShiftingRatio: 0.5,
          spaceAfterMessage: defaultSpaceAfterMessage,
          robotWidth: robotWidth,
        ),
      );
    }

    // الشكل المخصص والمتجاوب من السؤال الثالث إلى الأخير
    return DefaultTextStyle(
      style: messageStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // الفقاعة في المنتصف / اليمين
          Align(
            alignment: const Alignment(0.3, 0),
            child: SpeakingRobot(
              message: message,
              robotImagePath: Assets.images.greenRobotThinking.path,
              isMessageOneLine: true,
              messageShiftingRatio: 0.8,
              spaceAfterMessage: 0,
              robotWidth: 0,
            ),
          ),

          // مسافة رأسية ديناميكية تتكيف مع طول الشاشة
          SizedBox(height: responsiveVerticalSpacing),

          // الروبوت أقصى الشمال
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              Assets.images.greenRobotThinking.path,
              width: robotWidth,
            ),
          ),
        ],
      ),
    );
  }
}
