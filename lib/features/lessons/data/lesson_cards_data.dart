import 'package:volt/core/theme/app_colors.dart';
import 'package:volt/features/lessons/data/models/lesson_question_item_model.dart';

abstract class LessonCardsData {
  static const List<LessonItemModel> initialCards = [
    LessonItemModel(
      id: '1',
      title: 'Level 1 Lesson 1',
      message: 'هل تساءلت يوماً كيف تعمل لعبة أو أجهزة الألعاب الحديثة؟',
      robotImagePath: 'assets/images/robot_happy.png',
      contentImagePath: 'assets/images/car.png',
      buttonColor: AppColors.brandSecondaryGreen,
    ),
    LessonItemModel(
      id: '2',
      title: 'Level 1 Lesson 1',
      message: 'الكهرباء هي الحركة المتتابعة للإلكترونات مع إنتقال شحنات محددة داخل السلك.',
      robotImagePath: 'assets/images/robot_happy.png',
      contentImagePath: 'assets/images/circuit_dots.png',
      buttonColor: AppColors.brandSecondaryGreen,
    ),
    LessonItemModel(
      id: '3',
      title: 'Level 1 Lesson 1',
      message:
          'الكهرباء القوية تأتي إلى منازلنا من محطات ضخمة عبر أسطح المولدات وشبكات عالية جداً.',
      robotImagePath: 'assets/images/robot_happy.png',
      contentImagePath: 'assets/images/power_station.png',
      buttonColor: AppColors.brandSecondaryGreen,
    ),
    LessonItemModel(
      id: '4',
      title: 'Level 1 Lesson 1',
      message:
          'الكهرباء طاقة يمكن تحويلها إلى ضوء في المصباح وإلى صوت في التلفاز وإلى حركة في المروحة.',
      robotImagePath: 'assets/images/robot_happy.png',
      contentImagePath: 'assets/images/tv_icon.png',
      buttonColor: AppColors.brandSecondaryGreen,
    ),
    LessonItemModel(
      id: '5',
      title: 'Level 1 Lesson 1',
      message: 'ماذا عن بعض الأسئلة للتأكد من مستوى فهمك؟',
      robotImagePath: 'assets/images/robot_thinking.png',
      buttonColor: AppColors.brandSecondaryGreen,
    ),
  ];
}
