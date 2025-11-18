part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class BookChangeDateOnProfileState extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  ProfileLoaded(this.profile);

  final ProfileData profile;
}

final class ProfileError extends ProfileState {
  ProfileError(this.message);

  final String message;
}

final class ProfileUpdateLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {
  ProfileUpdateSuccess(this.profile);

  final ProfileData profile;
}

final class ProfileUpdateFailure extends ProfileState {
  ProfileUpdateFailure(this.message);

  final String message;
}

final class ProfileChangePasswordLoading extends ProfileState {}

final class ProfileChangePasswordSuccess extends ProfileState {
  ProfileChangePasswordSuccess(this.message);

  final String message;
}

final class ProfileChangePasswordFailure extends ProfileState {
  ProfileChangePasswordFailure(this.message);

  final String message;
}

final class ProfileBookingsLoading extends ProfileState {}

final class ProfileBookingsSuccess extends ProfileState {
  ProfileBookingsSuccess(this.bookings);

  final List<BookingModel> bookings;
}

final class ProfileBookingsFailure extends ProfileState {
  ProfileBookingsFailure(this.message);

  final String message;
}
