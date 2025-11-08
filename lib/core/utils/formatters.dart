import 'package:flutter/services.dart';

/// 🌟 formatters.dart
/// ------------------------------------------------------------
/// A utility class that provides reusable input formatters
/// for form fields across the app. All formatters are static,
/// ensuring clean and readable usage inside TextFormFields.
/// ------------------------------------------------------------
class Formatters {
  // 🛡️ Private constructor — prevents instantiation
  Formatters._();

  /// 🔢 Allows only digits (0–9)
  static final digitsOnly =
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  /// 🔠 Allows only English letters (A–Z, a–z)
  static final englishLetters =
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));

  /// 🔤 Allows only Arabic letters (Unicode range)
  static final arabicLetters =
  FilteringTextInputFormatter.allow(RegExp(r'[\u0600-\u06FF\s]'));

  /// 🌍 Allows both Arabic and English letters
  static final letters =
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF\s]'));

  /// 💰 Allows numeric input with up to 2 decimal places (e.g., prices)
  static final price =
  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  /// 🚫 Denies leading spaces (prevents accidental spaces at start)
  static final noLeadingSpace =
  FilteringTextInputFormatter.deny(RegExp(r'^ +'));

  /// 📱 Allows only digits, limits input length to 11 (Egyptian phone numbers)
  static final phoneNumber = <TextInputFormatter>[
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(11),
  ];

  /// 📧 Allows email-safe characters only
  static final email =
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]'));

  /// 🔠 Automatically converts all input to uppercase
  static final toUpperCase = TextInputFormatter.withFunction(
        (oldValue, newValue) =>
        newValue.copyWith(text: newValue.text.toUpperCase()),
  );

  /// 🔡 Automatically converts all input to lowercase
  static final toLowerCase = TextInputFormatter.withFunction(
        (oldValue, newValue) =>
        newValue.copyWith(text: newValue.text.toLowerCase()),
  );

  /// 🚗 Custom formatter: allows car plate formats like "ABC 1234"
  static final carPlate =
  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z\u0600-\u06FF0-9\s]'));

  /// 💬 Trims multiple consecutive spaces to one
  static final singleSpaceOnly = TextInputFormatter.withFunction(
        (oldValue, newValue) {
      final trimmed = newValue.text.replaceAll(RegExp(r'\s+'), ' ');
      return newValue.copyWith(text: trimmed);
    },
  );
}
