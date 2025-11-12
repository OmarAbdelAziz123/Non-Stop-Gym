import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:non_stop/core/errors/failures.dart' as errors;
import 'package:non_stop/core/network/api_result.dart' as api_result;
import 'package:non_stop/core/services/di/dependency_injection.dart';
import 'package:non_stop/features/profile/data/models/profile_response.dart';
import 'package:non_stop/features/profile/data/repos/profile_repository.dart';
import 'package:table_calendar/table_calendar.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({ProfileRepository? profileRepository})
      : _profileRepository = profileRepository ?? getIt<ProfileRepository>(),
        super(ProfileInitial());

  final ProfileRepository _profileRepository;

  DateTime focusedDay = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));
  ProfileData? profileData;

  void updateFocusedDay(DateTime day) {
    final firstDay = DateTime.now();

    if ((day.isAfter(firstDay) || isSameDay(day, firstDay)) &&
        (day.isBefore(endDate) || isSameDay(day, endDate))) {
      focusedDay = day;
      emit(BookChangeDateOnProfileState());
    }
  }

  void chooseBookingDate(DateTime dateTime) async {
    selectedDate = dateTime;
    emit(BookChangeDateOnProfileState());
  }

  void notifyProfileChanged() {
    if (profileData != null) {
      emit(ProfileLoaded(profileData!));
    }
  }

  Future<void> fetchProfile() async {
    emit(ProfileLoading());

    final api_result.ApiResult<ProfileData> result =
        await _profileRepository.fetchProfile();

    if (result is api_result.Success<ProfileData>) {
      profileData = result.data;
      emit(ProfileLoaded(result.data));
      return;
    }

    if (result is api_result.Failure<ProfileData>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(ProfileError(message));
      return;
    }

    emit(ProfileError('Unexpected error occurred'));
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? phone,
    String? gender,
    File? imageFile,
  }) async {
    final hasChanges = [
      name,
      email,
      password,
      passwordConfirmation,
      phone,
      gender,
      imageFile
    ].any(
      (element) =>
          element != null &&
          ((element is String && element.trim().isNotEmpty) ||
              element is File),
    );

    if (!hasChanges) {
      emit(ProfileUpdateFailure('لا توجد تغييرات لتحديثها'));
      return;
    }

    emit(ProfileUpdateLoading());

    final api_result.ApiResult<ProfileData> result =
        await _profileRepository.updateProfile(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      phone: phone,
      gender: gender,
      imageFile: imageFile,
    );

    if (result is api_result.Success<ProfileData>) {
      profileData = result.data;
      emit(ProfileUpdateSuccess(result.data));
      emit(ProfileLoaded(result.data));
      return;
    }

    if (result is api_result.Failure<ProfileData>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(ProfileUpdateFailure(message));
      return;
    }

    emit(ProfileUpdateFailure('حدث خطأ غير متوقع'));
  }

  Future<void> changePassword({
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ProfileChangePasswordLoading());

    final api_result.ApiResult<ProfileData> result =
        await _profileRepository.updateProfile(
      password: newPassword,
      passwordConfirmation: confirmPassword,
    );

    if (result is api_result.Success<ProfileData>) {
      profileData = result.data;
      emit(ProfileChangePasswordSuccess('تم تحديث كلمة المرور بنجاح'));
      emit(ProfileLoaded(result.data));
      return;
    }

    if (result is api_result.Failure<ProfileData>) {
      final error = result.errorHandler;
      final message =
          error is errors.Failure ? error.message : error.toString();
      emit(ProfileChangePasswordFailure(message));
      return;
    }

    emit(ProfileChangePasswordFailure('حدث خطأ غير متوقع'));
  }
}
