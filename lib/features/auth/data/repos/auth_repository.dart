import 'package:dio/dio.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/constants/app_constants.dart';
import 'package:non_stop/core/errors/failures.dart';
import 'package:non_stop/core/network/api_result.dart';
import 'package:non_stop/features/auth/data/api_services/auth_api_services.dart';
import 'package:non_stop/features/auth/data/models/login_response.dart';
import 'package:non_stop/features/auth/data/models/register_response.dart';

class AuthRepository {
  AuthRepository(this._authApiServices);

  final AuthApiServices _authApiServices;

  Future<ApiResult<LoginResponse>> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _authApiServices.login(
        phone: phone,
        password: password,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        await _saveSession(loginResponse);
        return ApiResult.success(loginResponse);
      }

      final message = _extractErrorMessage(response.data) ?? 'Login failed';
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

  Future<ApiResult<String>> forgetPassword({required String email}) async {
    try {
      final response = await _authApiServices.forgetPassword(email: email);

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message = response.data?['message']?.toString() ??
            'reset OTP sent to your email';
        return ApiResult.success(message);
      }

      final message = _extractErrorMessage(response.data) ?? 'Request failed';
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

  Future<ApiResult<String>> verifyOtp({
    required String email,
    required String otp,
    required String type,
  }) async {
    try {
      final response = await _authApiServices.verifyOtp(
        email: email,
        otp: otp,
        type: type,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>? ?? {};
        final message =
            data['message']?.toString() ?? 'OTP verified successfully';

        if (type == 'registration') {
          final loginResponse = LoginResponse.fromJson(data);
          await _saveSession(loginResponse);
        } else {
          final resetToken = data['data']?['reset_token']?.toString();
          if (resetToken != null) {
            await CacheHelper.saveSecuredString(
              key: CacheKeys.tokenInOTP,
              value: resetToken,
            );
          }
        }

        return ApiResult.success(message);
      }

      final message = _extractErrorMessage(response.data) ?? 'Verification failed';
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

  Future<ApiResult<String>> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _authApiServices.createNewPassword(
        newPassword: password,
        newPasswordConfirmation: passwordConfirmation,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final message =
            response.data?['message']?.toString() ?? 'Password reset successfully';
        await CacheHelper.saveSecuredString(
          key: CacheKeys.tokenInOTP,
          value: '',
        );
        return ApiResult.success(message);
      }

      final message = _extractErrorMessage(response.data) ?? 'Reset failed';
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

  Future<ApiResult<RegisterResponse>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String countryCode,
    required String phone,
    required String gender,
  }) async {
    try {
      final response = await _authApiServices.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        countryCode: countryCode,
        phone: phone,
        gender: gender,
      );

      if (response == null) {
        return const ApiResult.failure(
          NetworkFailure('No response from server'),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final registerResponse = RegisterResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return ApiResult.success(registerResponse);
      }

      final message = _extractErrorMessage(response.data) ?? 'Register failed';
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

  Future<void> _saveSession(LoginResponse loginResponse) async {
    final loginData = loginResponse.data;
    final user = loginData?.user;

    await CacheHelper.saveSecuredString(
      key: CacheKeys.userToken,
      value: loginData?.token ?? '',
    );
    await CacheHelper.saveSecuredString(
      key: CacheKeys.tokenInOTP,
      value: '',
    );

    if (user != null) {
      await CacheHelper.saveData(
        key: CacheKeys.userName,
        value: user.name ?? '',
      );
      await CacheHelper.saveData(
        key: CacheKeys.userImage,
        value: user.image ?? '',
      );
      await CacheHelper.saveData(
        key: CacheKeys.userPhone,
        value: user.phone ?? '',
      );
      await CacheHelper.saveData(
        key: CacheKeys.userEmail,
        value: user.email ?? '',
      );
      if (user.gender != null) {
        await CacheHelper.saveData(
          key: CacheKeys.userGender,
          value: user.gender,
        );
      }
    }

    AppConstants.userToken = await CacheHelper.getSecuredString(
      key: CacheKeys.userToken,
    );
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

