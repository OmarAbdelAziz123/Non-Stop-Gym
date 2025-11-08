/// 🌟 validators.dart
/// ------------------------------------------------------------
/// A utility class providing common form field validation logic
/// used across the application. Each method returns a nullable
/// String — returning `null` means the input is valid.
/// ------------------------------------------------------------
class Validators {
  // Private constructor to prevent instantiation
  Validators._();

  /// ✅ Generic helper: checks if value is null or empty
  static bool _isEmpty(String? value) =>
      value == null || value.trim().isEmpty;

  /// ✅ Required field validator
  static String? requiredField(String? value,
      {String fieldName = 'هذا الحقل'}) {
    if (_isEmpty(value)) return '$fieldName مطلوب';
    return null;
  }

  /// 📧 Email format validator
  static String? email(String? value) {
    if (_isEmpty(value)) return 'البريد الإلكتروني مطلوب';

    // RFC 5322 simplified pattern
    final emailRegExp =
    RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

    if (!emailRegExp.hasMatch(value!.trim())) {
      return 'يرجى إدخال بريد إلكتروني صالح';
    }
    return null;
  }

  /// 📱 Egyptian phone number validator (11 digits)
  static String? phone(String? value) {
    if (_isEmpty(value)) return 'رقم الهاتف مطلوب';

    // Supports only 010, 011, 012, 015 prefixes
    final phoneRegExp = RegExp(r'^(010|011|012|015)\d{8}$');

    if (!phoneRegExp.hasMatch(value!.trim())) {
      return 'يرجى إدخال رقم هاتف مصري صحيح';
    }
    return null;
  }

  /// 🔐 Password strength validator
  static String? password(String? value, {int minLength = 6}) {
    if (_isEmpty(value)) return 'كلمة المرور مطلوبة';

    if (value!.length < minLength) {
      return 'كلمة المرور يجب أن تكون على الأقل $minLength أحرف';
    }

    // Optional advanced check for strong passwords:
    // at least one letter and one number
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasDigit = RegExp(r'\d').hasMatch(value);
    if (!hasLetter || !hasDigit) {
      return 'يجب أن تحتوي كلمة المرور على حروف وأرقام';
    }

    return null;
  }

  /// 🔁 Confirm password validator
  static String? confirmPassword(String? value, String originalPassword) {
    if (_isEmpty(value)) return 'يرجى تأكيد كلمة المرور';
    if (value!.trim() != originalPassword.trim()) {
      return 'كلمة المرور غير متطابقة';
    }
    return null;
  }

  /// 🧍 Name validator (Arabic or English letters only)
  static String? name(String? value, {String fieldName = 'الاسم'}) {
    if (_isEmpty(value)) return '$fieldName مطلوب';

    final nameRegExp = RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$');
    if (!nameRegExp.hasMatch(value!.trim())) {
      return 'يرجى إدخال $fieldName صالح (بدون أرقام أو رموز)';
    }
    return null;
  }

  /// 🔢 Numeric-only validator
  static String? number(String? value, {String fieldName = 'القيمة'}) {
    if (_isEmpty(value)) return '$fieldName مطلوبة';
    if (!RegExp(r'^[0-9]+$').hasMatch(value!.trim())) {
      return 'يرجى إدخال أرقام فقط';
    }
    return null;
  }

  /// 💰 Price validator (supports decimal up to 2 digits)
  static String? price(String? value, {String fieldName = 'السعر'}) {
    if (_isEmpty(value)) return '$fieldName مطلوب';
    if (!RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value!.trim())) {
      return 'يرجى إدخال $fieldName صالح (مثلاً 100 أو 99.99)';
    }
    return null;
  }

  /// 🚗 License plate validator (e.g., "ABC 1234")
  static String? carPlate(String? value) {
    if (_isEmpty(value)) return 'رقم اللوحة مطلوب';
    final plateRegExp = RegExp(r'^[A-Za-z\u0600-\u06FF]{1,3}\s?\d{1,4}$');
    if (!plateRegExp.hasMatch(value!.trim())) {
      return 'يرجى إدخال رقم لوحة صالح (مثلاً ABC 1234)';
    }
    return null;
  }

  /// 🧾 Username validator (no spaces, letters/numbers only)
  static String? username(String? value) {
    if (_isEmpty(value)) return 'اسم المستخدم مطلوب';
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value!.trim())) {
      return 'اسم المستخدم يجب أن يحتوي على أحرف أو أرقام فقط بدون مسافات';
    }
    return null;
  }
}
