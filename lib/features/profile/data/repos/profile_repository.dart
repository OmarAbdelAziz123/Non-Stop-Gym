import 'dart:io';

import 'package:dio/dio.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/profile/data/api_services/profile_api_services.dart';
import 'package:non_stop/features/profile/data/models/profile_response.dart';
import 'package:non_stop/features/profile/data/models/booking_response.dart';

class ProfileRepository {
  ProfileRepository(this._profileApiServices);

  final ProfileApiServices _profileApiServices;

  Future<ApiResult<ProfileData>> fetchProfile() async {
    try {
      final response = await _profileApiServices.fetchProfile();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileResponse = ProfileResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final data = profileResponse.data;
        if (data != null) {
          await _saveProfileLocally(data);
          return ApiResult.success(data);
        }
        return const ApiResult.failure(
          UnknownFailure('Empty profile data'),
        );
      }

      final message = _extractErrorMessage(response.data) ?? 'Fetch failed';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      final message = _extractErrorMessage(error.response?.data) ??
          error.message ??
          'Unexpected error occurred';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: statusCode,
        ),
      );
    } catch (error) {
      return ApiResult.failure(
        UnknownFailure(error.toString()),
      );
    }
  }

  Future<ApiResult<ProfileData>> updateProfile({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? phone,
    String? gender,
    File? imageFile,
  }) async {
    try {
      final response = await _profileApiServices.updateProfile(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        phone: phone,
        gender: gender,
        imageFile: imageFile,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileResponse = ProfileResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        final data = profileResponse.data;
        if (data != null) {
          await _saveProfileLocally(data);
          return ApiResult.success(data);
        }
        return const ApiResult.failure(
          UnknownFailure('Empty profile data'),
        );
      }

      final message = _extractErrorMessage(response.data) ?? 'Update failed';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      final message = _extractErrorMessage(error.response?.data) ??
          error.message ??
          'Unexpected error occurred';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: statusCode,
        ),
      );
    } catch (error) {
      return ApiResult.failure(
        UnknownFailure(error.toString()),
      );
    }
  }

  String? _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data['message'] is String) {
        return data['message'] as String;
      }
      if (data['error'] is String) {
        return data['error'] as String;
      }
      final errorsField = data['errors'];
      if (errorsField is List && errorsField.isNotEmpty) {
        return errorsField.first.toString();
      }
      if (errorsField is Map && errorsField.isNotEmpty) {
        final firstEntry = errorsField.entries.first.value;
        if (firstEntry is List && firstEntry.isNotEmpty) {
          return firstEntry.first.toString();
        }
        return firstEntry.toString();
      }
    }
    return null;
  }

  Future<void> _saveProfileLocally(ProfileData profile) async {
    await CacheHelper.saveData(
      key: CacheKeys.userName,
      value: profile.name ?? '',
    );
    await CacheHelper.saveData(
      key: CacheKeys.userEmail,
      value: profile.email ?? '',
    );
    await CacheHelper.saveData(
      key: CacheKeys.userPhone,
      value: profile.phone ?? '',
    );
    if (profile.gender != null) {
      await CacheHelper.saveData(
        key: CacheKeys.userGender,
        value: profile.gender,
      );
    }
    if (profile.image != null) {
      await CacheHelper.saveData(
        key: CacheKeys.userImage,
        value: profile.image,
      );
    }
  }

  Future<ApiResult<List<BookingModel>>> getUserBookings(String status) async {
    try {
      final response = await _profileApiServices.getUserBookings(status);

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bookingResponse = BookingResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(bookingResponse.data ?? []);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load bookings';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (error) {
      final statusCode = error.response?.statusCode;
      final message = _extractErrorMessage(error.response?.data) ??
          error.message ??
          'Unexpected error occurred';
      return ApiResult.failure(
        NetworkFailure(
          message,
          statusCode: statusCode,
        ),
      );
    } catch (error) {
      return ApiResult.failure(
        UnknownFailure(error.toString()),
      );
    }
  }
}

