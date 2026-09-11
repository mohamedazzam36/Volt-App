abstract final class ApiEndpoints {
  // ================= Auth =================
  static const String guest = 'auth/guest';
  static const String register = 'auth/register';
  static const String login = 'auth/login';
  static const String google = 'auth/google';
  static const String refresh = 'auth/refresh';
  static const String logout = 'auth/logout';
  static const String forgotPassword = 'auth/forgot-password';
  static const String verifyResetOtp = 'auth/verify-reset-otp';
  static const String resetPassword = 'auth/reset-password';

  // ================= Users =================
  static const String userMe = 'users/me';

  // ================= Content Types =================
  static const String contentTypes = 'content/content-types';

  // ================= Levels =================
  static const String levels = 'content/levels';
  static const String swapLevelsOrder = 'content/levels/swap-order';

  static String levelDetails(String id) => 'content/levels/$id';
  static String levelLessons(String levelId) => 'content/levels/$levelId/lessons';

  // ================= Lessons =================
  static const String lessons = 'content/lessons';
  static const String swapLessonsOrder = 'content/lessons/swap-order';

  static String lessonDetails(String id) => 'content/lessons/$id';
  static String publishLesson(String id) => 'content/lessons/$id/publish';
  static String lessonContents(String lessonId) => 'content/lessons/$lessonId/contents';

  // ================= Contents =================
  static const String swapContentsOrder = 'content/contents/swap-order';

  static String contentDetails(String contentId) => 'content/contents/$contentId';

  // ================= Media =================
  static const String uploadMediaImages = 'content/media/images';
}
