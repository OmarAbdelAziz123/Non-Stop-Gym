import 'package:dio/dio.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/home/data/api_services/home_api_services.dart';
import 'package:non_stop/features/home/data/models/available_slots_response.dart';
import 'package:non_stop/features/home/data/models/banner_response.dart';
import 'package:non_stop/features/home/data/models/settings_response.dart';
import 'package:non_stop/features/home/data/models/faq_response.dart';

class HomeRepository {
  HomeRepository(this._homeApiServices);

  final HomeApiServices _homeApiServices;

  Future<ApiResult<List<BannerModel>>> fetchBanners() async {
    try {
      final response = await _homeApiServices.fetchBanners();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final bannerResponse = BannerResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(bannerResponse.data ?? []);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load banners';
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

  Future<ApiResult<SettingsData>> fetchSettings() async {
    try {
      final response = await _homeApiServices.fetchSettings();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final settingsResponse = SettingsResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (settingsResponse.data != null) {
          return ApiResult.success(settingsResponse.data!);
        }
        return const ApiResult.failure(
          NetworkFailure('Settings data is null'),
        );
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load settings';
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

  Future<ApiResult<List<AvailableSlotModel>>> getAvailableBookingSlots(String date) async {
    try {
      final response = await _homeApiServices.getAvailableBookingSlots(date);

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final slotsResponse = AvailableSlotsResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(slotsResponse.data ?? []);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load available slots';
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

  Future<ApiResult<Map<String, dynamic>>> bookBooking(int bookingDateId) async {
    try {
      final response = await _homeApiServices.bookBooking(bookingDateId);

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>? ?? {};
        return ApiResult.success(responseData);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to book appointment';
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

  Future<ApiResult<List<FaqModel>>> fetchFaqs() async {
    try {
      final response = await _homeApiServices.fetchFaqs();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final faqResponse = FaqResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(faqResponse.data ?? []);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load FAQs';
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

