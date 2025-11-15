import 'package:dio/dio.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/packages/data/api_services/packages_api_services.dart';
import 'package:non_stop/features/packages/data/models/subscription_response.dart';

class PackagesRepository {
  PackagesRepository(this._packagesApiServices);

  final PackagesApiServices _packagesApiServices;

  Future<ApiResult<List<SubscriptionModel>>> fetchSubscriptions() async {
    try {
      final response = await _packagesApiServices.fetchSubscriptions();

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final subscriptionResponse = SubscriptionResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(subscriptionResponse.data ?? []);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load subscriptions';
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
}

