import 'package:volt/core/constants/app_strings.dart';
import 'package:volt/core/constants/assets.gen.dart';
import 'package:volt/features/quiz/data/models/option_model.dart';
import 'package:volt/features/quiz/data/models/question_model.dart';

class QuizRepository {
  Future<List<QuestionModel>> getQuestions() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return [
      // 1. سؤال كتابي
      QuestionModel(
        id: '1',
        title: QuizStrings.whatIsDiffVoltageCurrent,
        type: QuestionType.fillInBlank,
        correctAnswer: 'الفرق في الجهد يدفع التيار للتدفق',
      ),

      // 2. اختيار الصورة (أين المقاومة؟)
      QuestionModel(
        id: '2',
        title: QuizStrings.whereIsResistor,
        type: QuestionType.imageChoice,
        options: [
          OptionModel(id: '1', imageUrl: Assets.images.battery1.path),
          OptionModel(id: '2', imageUrl: Assets.images.potentiometer1.path),
          OptionModel(id: '3', imageUrl: Assets.images.led1.path),
          OptionModel(id: '4', imageUrl: Assets.images.resistor1.path),
        ],
        correctAnswer: '4', // resistor1 هي المقاومة
      ),

      // 3. اختيار من متعدد (وحدة قياس شدة التيار)
      QuestionModel(
        id: '3',
        title: QuizStrings.whatIsCurrentUnit,
        type: QuestionType.mcq,
        options: [
          OptionModel(id: '1', text: QuizStrings.ampere),
          OptionModel(id: '2', text: QuizStrings.volt),
          OptionModel(id: '3', text: QuizStrings.joule),
          OptionModel(id: '4', text: QuizStrings.ohm),
        ],
        correctAnswer: '1', // الأمبير
      ),

      // 4. إكمال الجملة (يقاس الجهد الكهربائي بوحدة...)
      QuestionModel(
        id: '4',
        title: QuizStrings.voltageIsMeasuredIn,
        type: QuestionType.wordChips,
        options: [
          OptionModel(id: '1', text: QuizStrings.ampere),
          OptionModel(id: '2', text: QuizStrings.volt),
          OptionModel(id: '3', text: QuizStrings.watt),
        ],
        correctAnswer: '2', // الفولت
      ),

      // 5. صح أو خطأ (المقاومة تقلل من شدة التيار)
      QuestionModel(
        id: '5',
        title: QuizStrings.resistorReducesCurrent,
        type: QuestionType.trueFalse,
        correctAnswer: true,
      ),

      // 6. صح أو خطأ (الأمبير هو وحدة قياس شدة التيار)
      QuestionModel(
        id: '6',
        title: QuizStrings.ampereIsCurrentUnit,
        type: QuestionType.trueFalse,
        correctAnswer: true,
      ),
    ];
  }

  Future<QuestionModel> getQuestionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));

    return QuestionModel(
      id: id,
      title: QuizStrings.whatUnitIsElectricChargeMeasuredIn,
      type: QuestionType.mcq,
      options: [
        OptionModel(id: '1', text: QuizStrings.volt),
        OptionModel(id: '2', text: QuizStrings.ohm),
        OptionModel(id: '3', text: QuizStrings.coulomb),
        OptionModel(id: '4', text: QuizStrings.ampere),
      ],
      correctAnswer: '3', // كولوم
    );
  }
}