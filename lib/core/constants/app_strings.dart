/// نصوص عامة مشتركة في التطبيق كله
abstract final class CommonStrings {
  static const String appName = 'فولت';
  static const String next = 'التالي';
  static const String skip = 'تخطي';
  static const String continueAction = 'متابعة';
}

/// شاشة السبلاش
abstract final class SplashStrings {
  static const String chargingMessage = 'يلا نشحن طاقة لعلمك!';
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
}

/// نصوص المصادقة والتسجيل بالكامل (Auth)
abstract final class AuthStrings {
  // أزرار الدخول والتسجيل
  static const String createAccount = 'إنشاء حساب';
  static const String login = 'تسجيل الدخول';
  static const String continueAsGuest = 'المتابعة كضيف';
  static const String googleSignIn = 'جوجل';

  // الشروط وسياسة الخصوصية
  static const String termsPrefix = 'بالتسجيل  في فولت، أنت توافق على';
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
  static const String letsGo = 'هيا بنا !';

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
