import 'package:dio/dio.dart';
import 'package:non_stop/core/cache_helper/cache_helper.dart';
import 'package:non_stop/core/cache_helper/cache_keys.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class AuthApiServices {
  AuthApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  /// Login
  Future<Response?> login({
    required String phone,
    required String password,
  }) async {
    return _dioHelper.post(
      endPoint: EndPoints.login,
      data: {
        'login': phone,
        'password': password,
        // 'fcm_token': CacheHelper.getData(key: CacheKeys.deviceToken),
      },
    );
  }

  /// Register
  Future<Response?> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String countryCode,
    required String phone,
    required String gender,
  }) async {
    return _dioHelper.post(
      endPoint: EndPoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'country_code': countryCode,
        'phone': phone,
        'gender': gender,
      },
    );
  }

  /// Forget password
  Future<Response?> forgetPassword({required String email}) {
    return _dioHelper.post(
      endPoint: EndPoints.forgetPassword,
      data: {'email': email},
    );
  }

  /// Verify code
  // Future<Response?> verifyCode({
  //   required String password,
  //   required String verificationCode,
  //   required String passwordConfirm,
  // }) {
  //   return _dioHelper.post(
  //     endPoint: EndPoints.v,
  //     data: {
  //       'code': verificationCode,
  //       'password': password,
  //       'password_confirmation': passwordConfirm,
  //     },
  //   );
  // }

  Future<Response?> verifyOtp({
    required String email,
    required String otp,
    required String type,
  }) {
    return _dioHelper.post(
      endPoint: EndPoints.verifyOtp,
      data: {
        'email': email,
        'otp': otp,
        'type': type,
      },
    );
  }

  /// Create a new password
  Future<Response?> createNewPassword({
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    final token =
        await CacheHelper.getSecuredString(key: CacheKeys.tokenInOTP);

    return _dioHelper.post(
      endPoint: EndPoints.resetPassword,
      data: {
        'password': newPassword,
        'password_confirmation': newPasswordConfirmation,
      },
      options: token != null
          ? Options(
              headers: {
                'Authorization': 'Bearer $token',
              },
            )
          : null,
    );
  }

  /// Logout
  // Future<Response?> logout() {
  //   return _dioHelper.post(
  //     endPoint: EndPoints.logout,
  //   );
  // }
}

