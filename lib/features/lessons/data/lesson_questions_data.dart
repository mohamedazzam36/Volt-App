import 'package:volt/features/lessons/data/models/lesson_questio_item_model.dart';

class LessonQuestionsData {
  static final List<LessonQuestionItemModel> lessons = [
  

    // 2. السؤال الأول (Multiple Choice)
    const LessonQuestionItemModel(
      message: 'من اين تنشأ الكهرباء في سيارات اللعب؟',
      contentImagePath: "assets/images/car.png",
      questionType: LessonQuestionType.multipleChoice,
      options: ['من بطاريات السيارة', 'من الاحتكاك', 'الرياح', 'الضوء'],
      correctAnswer: 'من بطاريات السيارة',
    ),

    // 3. السؤال الثاني (True / False)
    const LessonQuestionItemModel(
      message: 'هل البرق نوع من أنواع الكهرباء الطبيعية الخطيرة؟',
      contentImagePath: 'assets/images/lightning_icon.png',
      questionType: LessonQuestionType.trueFalse,
      correctAnswer: 'صح',
    ),

    // 4. السؤال الثالث (Multiple Choice)
    const LessonQuestionItemModel(
      message: 'أي من هذه الأجهزة يعتمد بشكل أساسي على الكهرباء؟',
      contentImagePath: 'assets/images/appliances_icon.png',
      questionType: LessonQuestionType.multipleChoice,
      options: ['المغناطيس', 'الغسالة الكهربائية', 'المصباح اليدوي القديم', 'لا شيء مما سبق'],
      correctAnswer: 'الغسالة الكهربائية',
    ),

    // 5. السؤال الرابع (True / False)
    const LessonQuestionItemModel(
      message: 'هل تقوم البطارية بتخزين الطاقة وتحويلها لصورة كهرباء؟',
      contentImagePath: 'assets/images/battery_icon.png',
      questionType: LessonQuestionType.trueFalse,
      correctAnswer: 'صح',
    ),

    // 6. السؤال الخامس (Multiple Choice)
    const LessonQuestionItemModel(
      message: 'ما الذي يسمح بمرور التيار الكهربائي بسلاسة خلاله؟',
      contentImagePath: 'assets/images/dots_icon.png',
      questionType: LessonQuestionType.multipleChoice,
      options: ['الموّصلات', 'العوازل', 'الخشب', 'البلاستيك'],
      correctAnswer: 'الموّصلات',
    ),

    // 7. السؤال السادس (True / False)
    const LessonQuestionItemModel(
      message: 'لكي يضيء المصباح، هل يجب أن تكون الدائرة الكهربائية مغلقة؟',
      contentImagePath: 'assets/images/circuit_icon.png',
      questionType: LessonQuestionType.trueFalse,
      correctAnswer: 'صح',
    ),

    // 8. السؤال السابع (Multiple Choice)
    const LessonQuestionItemModel(
      message: 'أين يتم توليد الكهرباء بكميات ضخمة لتكفي المدن؟',
      contentImagePath: 'assets/images/tower_icon.png',
      questionType: LessonQuestionType.multipleChoice,
      options: ['في الخلايا الشمسية الصغيرة', 'في محطات توليد الطاقة', 'في البطاريات الصغيرة', 'داخل الهواتف'],
      correctAnswer: 'في محطات توليد الطاقة',
    ),

    // 9. السؤال الثامن (Text Input)
    const LessonQuestionItemModel(
      message: 'اكتب اسم الوحدة الأساسية لقياس شدة التيار الكهربائي:',
      questionType: LessonQuestionType.textInput,
      correctAnswer: 'امبير',
    ),


  ];
}