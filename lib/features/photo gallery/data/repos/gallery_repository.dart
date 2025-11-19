import 'dart:io';

import 'package:dio/dio.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/photo gallery/data/api_services/gallery_api_services.dart';
import 'package:non_stop/features/photo gallery/data/models/gallery_response.dart';

class GalleryRepository {
  GalleryRepository(this._galleryApiServices);

  final GalleryApiServices _galleryApiServices;

  Future<ApiResult<GalleryData>> getGallery({
    int perPage = 15,
    int page = 1,
  }) async {
    try {
      final response = await _galleryApiServices.getGallery(
        perPage: perPage,
        page: page,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final galleryResponse = GalleryResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (galleryResponse.data != null) {
          return ApiResult.success(galleryResponse.data!);
        }
        return const ApiResult.failure(
          NetworkFailure('Gallery data is null'),
        );
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to load gallery';
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

  Future<ApiResult<Map<String, dynamic>>> addGalleryItem({
    required File imageFile,
    required String comment,
  }) async {
    try {
      final response = await _galleryApiServices.addGalleryItem(
        imageFile: imageFile,
        comment: comment,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        return ApiResult.success(responseData);
      }

      final message = _extractErrorMessage(response.data) ?? 'Failed to add gallery item';
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

