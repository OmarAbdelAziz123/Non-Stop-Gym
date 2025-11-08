mixin FormValidationMixin {
  bool isEmailValid(String? email) {
    if (email == null || email.isEmpty) return false;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  bool isPasswordStrong(String? password) {
    if (password == null || password.length < 8) return false;
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).+$');
    return regex.hasMatch(password);
  }

  bool isPhoneValid(String? phone) {
    if (phone == null) return false;
    final regex = RegExp(r'^\+?\d{7,15}$');
    return regex.hasMatch(phone);
  }
}
