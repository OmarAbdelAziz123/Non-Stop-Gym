import 'package:dio/dio.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/notification/data/api_services/notification_api_services.dart';
import 'package:non_stop/features/notification/data/models/notification_response.dart';

class NotificationRepository {
  NotificationRepository(this._notificationApiServices);

  final NotificationApiServices _notificationApiServices;

  Future<ApiResult<NotificationData>> getNotifications({
    int perPage = 15,
    int page = 1,
  }) async {
    try {
      final response = await _notificationApiServices.getNotifications(
        perPage: perPage,
        page: page,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final notificationResponse = NotificationResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (notificationResponse.data != null) {
          return ApiResult.success(notificationResponse.data!);
        }
        return const ApiResult.failure(
          NetworkFailure('Notification data is null'),
        );
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load notifications';
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

  Future<ApiResult<void>> deleteAllNotifications() async {
    try {
      final response = await _notificationApiServices.deleteAllNotifications();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return const ApiResult.success(null);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to delete notifications';
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

  Future<ApiResult<void>> markAllNotificationsAsRead() async {
    try {
      final response = await _notificationApiServices.markAllNotificationsAsRead();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 204) {
        return const ApiResult.success(null);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to mark notifications as read';
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
      if (data.containsKey('message') && data['message'] != null) {
        return data['message'].toString();
      }
      if (data.containsKey('error') && data['error'] != null) {
        return data['error'].toString();
      }
    }
    return null;
  }
}

