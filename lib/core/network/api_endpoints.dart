abstract final class ApiEndpoints {
  static const String guest = 'api/auth/guest';
  static const String register = 'api/auth/register';
  static const String login = 'api/auth/login';
  static const String google = 'api/auth/google';
  static const String refresh = 'api/auth/refresh';
  static const String logout = 'api/auth/logout';
  static const String forgotPassword = 'api/auth/forgot-password';
  static const String verifyResetOtp = 'api/auth/verify-reset-otp';
  static const String resetPassword = 'api/auth/reset-password';

  static const String userMe = 'api/users/me';

  static const String publishedLessons = 'api/content/lessons/published';

  static String lessonProgress(int lessonId) => 'api/content/lessons/$lessonId/progress';

  static String lessonDetails(int lessonId) => 'api/content/lessons/$lessonId';

  static String quizForLesson(int lessonId, {String lang = 'ar'}) =>
      'api/quizzes/for-lesson/$lessonId?language=$lang';

  static String startQuizAttempt(int quizId, {int? previousAttemptId, String lang = 'ar'}) {
    String url = 'api/quiz-attempts?quizId=$quizId&language=$lang';
    if (previousAttemptId != null) {
      url += '&previousAttemptId=$previousAttemptId';
    }
    return url;
  }

  static String submitAttempt(int attemptId, {String lang = 'ar'}) =>
      'api/quiz-attempts/$attemptId/submit?language=$lang';

  static const String placement = 'api/placement';

  static String placementStart({String lang = 'ar'}) => 'api/placement/start?language=$lang';

  static String quizHint({
    required int attemptId,
    required int questionId,
    String lang = 'ar',
  }) =>
      'api/quiz-attempts/$attemptId/questions/$questionId/hint?language=$lang';
}
