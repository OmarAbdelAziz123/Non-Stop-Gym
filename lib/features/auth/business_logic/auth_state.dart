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