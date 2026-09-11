/// نصوص عامة مشتركة في التطبيق كله
abstract final class CommonStrings {
  static const String appName = 'فولت';
  static const String next = 'التالي';
  static const String skip = 'تخطي';
  static const String continueAction = 'متابعة';
  static const String back = 'رجوع';
  static const String sent = 'إرسال';
}

/// شاشة السبلاش
abstract final class SplashStrings {
  static const String chargingMessage = 'هيا نشحن طاقة تعلمك!';
  static const String byCtrlZ = 'by CTRL-Z';
}

/// شاشات الـ Onboarding الأربعة
abstract final class OnboardingStrings {
  // شاشة 1
  static const String title1 = 'تعلم بذكاء وحافظ على حماسك';
  static const String subTitle1 = 'دروس تفاعلية وتحديات ممتعة وتطبيقات عملية';

  // شاشة 2
  static const String title2 = 'حقق العديد من الانجازات';
  static const String subTitle2 = 'العديد من التحديات مصممة خصيصاً لك';

  // شاشة 3
  static const String title3 = 'العب واستكشف مع فولت';
  static const String subTitle3 = 'رفيقك الذكي في التعلم';

  // شاشة 4
  static const String title4 = 'آمن للاطفال';
  static const String subTitle4 = 'تأكد من سلامتك مع فولت';
  static const String startPlaying = 'ابدأ اللعب';
  static const String login = 'دخول';
}

/// نصوص المصادقة والتسجيل بالكامل (Auth)
abstract final class AuthStrings {
  // أزرار الدخول والتسجيل
  static const String createAccount = 'إنشاء حساب';
  static const String login = 'تسجيل الدخول';
  static const String continueAsGuest = 'المتابعة كضيف';
  static const String googleSignIn = 'جوجل';

  // الشروط وسياسة الخصوصية
  static const String termsPrefix = 'بالتسجيل في فولت، أنت توافق على';
  static const String terms = 'الشروط';
  static const String and = 'و';
  static const String privacyPolicy = 'سياسة الخصوصية';
  static const String termsSuffix = 'الخاصة بنا.';

  // بالونات حوار الروبوت
  static const String robotWelcome = 'لتبدأ مغامرة الالكترونيات';
  static const String robotIntro = 'هيا بنا لانشاء حساب جديد !';
  static const String askRobotName = 'ما اسم الروبوت الخاص بك ؟';
  static const String greatRobotName = 'اسم رائع ! ⚡';
  static const String askEmail = 'كيف يمكننا الوصول اليك؟';
  static const String validEmailMessage = 'عظيم !';
  static const String emailErrorRobotMessage = 'يبدو ان هناك خطأ ما !';
  static const String robotWontLook = 'لن افتح عيناى !';
  static const String robotWillLook = 'حسنا سوف انظر !';
  static const String strongPassword = 'تبدو كلمة مرور قوية !';
  static const String readyToStartJourney = 'جاهز لبدأ الرحلة؟';

  // حقول الإدخال والـ Hints والتحقق
  static const String robotNameHint = 'المستخدم (لا تستخدم اسمك الحقيقي)';
  static const String surpriseMe = 'فاجئنى';
  static const String emailHint = 'ادخل بريدك الالكترونى';
  static const String invalidEmailError = 'هذا بريد الكترونى غير صالح';
  static const String passwordHint = 'كلمة المرور';

  // خطوة العمر والإنهاء
  static const String howOldAreYou = 'كم عمرك؟';
  static const String ageDescription = 'تحديد عمرك يضمن حصولك على تجربة فولت المناسبة لك!';
  static const String finishAccountCreation = 'انشاء الحساب';
  static const String startGame = 'ابدأ اللعب !';
}

/// نصوص شاشات الكويز والأسئلة التفاعلية
abstract final class QuizStrings {
  // بالونات حوار الروبوت والتوظيف
  static const String startDialogue1 = 'لدي فضول بشأن معرفة المسار المناسب لك';
  static const String startDialogue2 = 'لا تقلق إن لم تستطع الإجابة انا اعلم بأنك رائع !';
  static const String completeByChoosingWord = 'أكمل الجملة باختيار الكلمة المناسبة';

  // نصوص وعناوين الأسئلة
  static const String whereIsResistor = 'أين المقاومة؟';
  static const String whatIsCurrentUnit = 'ما هي الوحدة المستخدمة في قياس شدة التيار؟';
  static const String voltageIsMeasuredIn = 'يقاس الجهد الكهربائي بوحدة';
  static const String whatIsDiffVoltageCurrent = 'يا ترى ما هو الفرق بين الجهد والتيار؟';
  static const String resistorReducesCurrent = 'المقاومة تقلل من شدة التيار المار في الدائرة';
  static const String ampereIsCurrentUnit = 'الأمبير هو وحدة قياس شدة التيار؟';
  static const String whatUnitIsElectricChargeMeasuredIn = 'ما هي الوحدة التي تقاس بها الشحنة الكهربائية؟';

  // عناصر التحكم والإدخال
  static const String writeAnswerHere = 'اكتب إجابتك هنا...';
  static const String trueOption = 'صح';
  static const String falseOption = 'خطأ';
  static const String checkAnswer = 'تحقق';
  static const String selectAnswer = 'اختر الإجابة الصحيحة';

  // نصوص الخيارات المشتركة
  static const String ampere = 'أمبير';
  static const String volt = 'فولت';
  static const String joule = 'جول';
  static const String ohm = 'أوم';
  static const String watt = 'واط';
  static const String coulomb = 'كولوم';

  // نصوص الإجابة الصحيحة والنجاح
  static const String wellDoneCorrectAnswer = 'أحسنت! الإجابة صحيحة';
  static const String looksNotYourFirstTime = 'يبدو بأنها ليست مرتك الأولى في الالكترونيات!';

  // نصوص الإجابة الخاطئة والـ Bottom Sheet
  static const String ohNoError = 'يا الهى خطأ !!!';
  static const String dontWorryNextTimeEasier = 'لا بأس سيصبح الامر اسهل المرة القادمة';
}