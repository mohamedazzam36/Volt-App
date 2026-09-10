import '../constants/app_strings.dart';

abstract final class AppValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الإيميل مطلوب';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'صيغة الإيميل غير صحيحة';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
    }
    return null;
  }

  static int calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0;

    int score = 0;

    if (password.length >= 8) score++; // 1. الطول 8 أحرف على الأقل
    if (RegExp(r'[a-z]').hasMatch(password)) score++; // 2. حرف صغير
    if (RegExp(r'[A-Z]').hasMatch(password)) score++; // 3. حرف كبير
    if (RegExp(r'[0-9]').hasMatch(password)) score++; // 4. رقم
    if (RegExp(r'[!@#\$&*~%^()_+=<>?]').hasMatch(password)) score++; // 5. رمز خاص

    return score;
  }

  static String? validateName(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return AuthStrings.emptyNameError;
    }

    // يتأكد إن الاسم على الأقل حرفين
    if (text.length < 2) {
      return AuthStrings.shortNameError;
    }

    return null;
  }
}
