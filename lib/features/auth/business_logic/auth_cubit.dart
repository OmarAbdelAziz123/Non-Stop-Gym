import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  bool isObscure = true;
  bool isObscure2 = true;
  bool isCheck = false;

  bool hasMinLength = false;
  bool hasNumber = false;
  bool passwordsMatch = false;
  bool hasUpperOrLower = false;

  int remainingSeconds = 60;
  Timer? timer;
  bool canResend = false;

  void startTimer() {
    remainingSeconds = 60;
    canResend = false;
    timer?.cancel();

    emit(ResendTimerUpdatedState());

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingSeconds == 0) {
        t.cancel();
        canResend = true;
      } else {
        remainingSeconds--;
      }
      emit(ResendTimerUpdatedState());
    });
  }

  void resendCode() {
    startTimer();
  }

  bool isCodeComplete = false;

  void onCodeChanged(String code) {
    if (code.length == 6) {
      isCodeComplete = true;
    } else {
      isCodeComplete = false;
    }
    emit(CodeChangedState());
  }

  void validatePassword() {
    final password = passwordController.text;
    final confirmPassword = rePasswordController.text;

    hasMinLength = password.length >= 8;

    hasNumber = password.contains(RegExp(r'[0-9]'));

    passwordsMatch =
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;

    hasUpperOrLower = password.contains(RegExp(r'[a-zA-Z]'));

    emit(PasswordValidationState());
  }

  bool get isPasswordValid =>
      hasMinLength && hasNumber && passwordsMatch && hasUpperOrLower;

  void toggleCheckbox() {
    isCheck = !isCheck;
    emit(ToggleCheckboxState());
  }

  void toggleObscure() {
    isObscure = !isObscure;
    emit(TogglePasswordState());
  }

  void toggleObscure2() {
    isObscure2 = !isObscure2;
    emit(TogglePasswordState2());
  }

  @override
  Future<void> close() {
    timer?.cancel();
    passwordController.dispose();
    rePasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    genderController.dispose();
    ageController.dispose();
    locationController.dispose();
    verificationCodeController.dispose();
    return super.close();
  }
}
