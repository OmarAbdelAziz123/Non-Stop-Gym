import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/auth/data/models/login_response.dart';
import 'package:non_stop/features/auth/data/models/register_response.dart';
import 'package:non_stop/features/auth/data/repos/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthRepository? authRepository})
      : _authRepository = authRepository ?? getIt<AuthRepository>(),
        super(AuthInitial());

  final AuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController =
      TextEditingController(text: 'male');
  final TextEditingController ageController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();
  String? otpEmail;
  String otpFlowType = 'registration';
  String? lastOtp;

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
    if (otpFlowType == 'password_reset') {
      resendOtp();
    } else {
      startTimer();
    }
  }

  bool isCodeComplete = false;

  void onCodeChanged(String code) {
    isCodeComplete = code.length == 4;
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

  Future<void> register() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    emit(AuthRegisterLoading());

    final api_result.ApiResult<RegisterResponse> result =
        await _authRepository.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      passwordConfirmation: rePasswordController.text.trim(),
      countryCode: '+20',
      phone: phoneController.text.trim(),
      gender: genderController.text.trim().isEmpty
          ? 'male'
          : genderController.text.trim(),
    );

    if (result is api_result.Success<RegisterResponse>) {
      lastOtp = result.data.data?.otp;
      otpEmail = emailController.text.trim();
      otpFlowType = 'registration';
      startTimer();
      emit(AuthRegisterSuccess(result.data));
      return;
    }

    if (result is api_result.Failure<RegisterResponse>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(AuthRegisterFailure(message));
      return;
    }

    emit(AuthRegisterFailure('Unexpected error occurred'));
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    emit(AuthLoginLoading());

    final api_result.ApiResult<LoginResponse> result =
        await _authRepository.login(
      phone: phoneController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (result is api_result.Success<LoginResponse>) {
      emit(AuthLoginSuccess(result.data));
      return;
    }

    if (result is api_result.Failure<LoginResponse>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(AuthLoginFailure(message));
      return;
    }

    emit(AuthLoginFailure('Unexpected error occurred'));
  }

  Future<void> requestPasswordReset({bool isResend = false}) async {
    final email = isResend
        ? (otpEmail ?? emailController.text.trim())
        : emailController.text.trim();

    if (email.isEmpty) {
      emit(AuthForgetPasswordFailure('emailIsRequired'.tr()));
      return;
    }

    if (!isResend && !(formKey.currentState?.validate() ?? false)) {
      return;
    }

    emit(AuthForgetPasswordLoading());

    final result = await _authRepository.forgetPassword(email: email);

    if (result is api_result.Success<String>) {
      otpEmail = email;
      otpFlowType = 'password_reset';
      lastOtp = null;
      startTimer();
      emit(AuthForgetPasswordSuccess(result.data, isResend: isResend));
      return;
    }

    if (result is api_result.Failure<String>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(AuthForgetPasswordFailure(message));
      return;
    }

    emit(AuthForgetPasswordFailure('unexpectedErrorOccurred'.tr()));
  }

  Future<void> verifyOtpCode({String? email, String? type}) async {
    final otp = verificationCodeController.text.trim();
    if (otp.length < 4) {
      emit(AuthVerifyOtpFailure('pleaseEnterValidCode'.tr()));
      return;
    }

    final flowType = type ?? otpFlowType;
    final targetEmail = email ??
        (otpFlowType == 'registration'
            ? emailController.text.trim()
            : (otpEmail ?? emailController.text.trim()));

    if (targetEmail.isEmpty) {
      emit(AuthVerifyOtpFailure('emailNotAvailable'.tr()));
      return;
    }

    emit(AuthVerifyOtpLoading());

    final result = await _authRepository.verifyOtp(
      email: targetEmail,
      otp: otp,
      type: flowType,
    );

    if (result is api_result.Success<String>) {
      timer?.cancel();
      canResend = false;
      verificationCodeController.clear();
      otpFlowType = flowType;
      if (flowType == 'registration') {
        otpEmail = null;
      }
      emit(AuthVerifyOtpSuccess(result.data, flowType));
      return;
    }

    if (result is api_result.Failure<String>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(AuthVerifyOtpFailure(message));
      return;
    }

    emit(AuthVerifyOtpFailure('unexpectedErrorOccurred'.tr()));
  }

  Future<void> resetPassword() async {
    if (!(formKey.currentState?.validate() ?? false) || !isPasswordValid) {
      return;
    }

    emit(AuthResetPasswordLoading());

    final result = await _authRepository.resetPassword(
      password: passwordController.text.trim(),
      passwordConfirmation: rePasswordController.text.trim(),
    );

    if (result is api_result.Success<String>) {
      passwordController.clear();
      rePasswordController.clear();
      otpEmail = null;
      otpFlowType = 'registration';
      emit(AuthResetPasswordSuccess(result.data));
      return;
    }

    if (result is api_result.Failure<String>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(AuthResetPasswordFailure(message));
      return;
    }

    emit(AuthResetPasswordFailure('unexpectedErrorOccurred'.tr()));
  }

  Future<void> resendOtp() async {
    if (otpFlowType == 'password_reset') {
      await requestPasswordReset(isResend: true);
    } else {
      startTimer();
    }
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
