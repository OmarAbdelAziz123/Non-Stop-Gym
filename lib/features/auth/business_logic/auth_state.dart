// part of 'auth_cubit.dart';

// abstract class AuthState {}

// class AuthInitial extends AuthState {}

// class ToggleCheckboxState extends AuthState {}

// class TogglePasswordState extends AuthState {}

// class TogglePasswordState2 extends AuthState {}

// class ResendTimerUpdatedState extends AuthState {}

// class CodeChangedState extends AuthState {}
part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class ToggleCheckboxState extends AuthState {}

final class TogglePasswordState extends AuthState {}

final class TogglePasswordState2 extends AuthState {}

final class ResendTimerUpdatedState extends AuthState {}

final class CodeChangedState extends AuthState {}

final class PasswordValidationState extends AuthState {}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  AuthLoginSuccess(this.response);

  final LoginResponse response;
}

final class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message);

  final String message;
}

final class AuthRegisterLoading extends AuthState {}

final class AuthRegisterSuccess extends AuthState {
  AuthRegisterSuccess(this.response);

  final RegisterResponse response;
}

final class AuthRegisterFailure extends AuthState {
  AuthRegisterFailure(this.message);

  final String message;
}

final class AuthForgetPasswordLoading extends AuthState {}

final class AuthForgetPasswordSuccess extends AuthState {
  AuthForgetPasswordSuccess(this.message, {this.isResend = false});

  final String message;
  final bool isResend;
}

final class AuthForgetPasswordFailure extends AuthState {
  AuthForgetPasswordFailure(this.message);

  final String message;
}

final class AuthVerifyOtpLoading extends AuthState {}

final class AuthVerifyOtpSuccess extends AuthState {
  AuthVerifyOtpSuccess(this.message, this.flowType);

  final String message;
  final String flowType;
}

final class AuthVerifyOtpFailure extends AuthState {
  AuthVerifyOtpFailure(this.message);

  final String message;
}

final class AuthResetPasswordLoading extends AuthState {}

final class AuthResetPasswordSuccess extends AuthState {
  AuthResetPasswordSuccess(this.message);

  final String message;
}

final class AuthResetPasswordFailure extends AuthState {
  AuthResetPasswordFailure(this.message);

  final String message;
}