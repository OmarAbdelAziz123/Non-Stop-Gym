/// All API endpoints should be defined here.
/// This keeps your codebase consistent and centralized.
class EndPoints {
  static const String baseUrl = 'https://backend.truebalance.com.sa/';

  /// Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh-token';

  /// Storage Keys
  static const String accessTokenKey = 'ACCESS_TOKEN';
  static const String refreshTokenKey = 'REFRESH_TOKEN';
  static const String fcmTokenKey = 'FCM_TOKEN';
}


// final token = response.data['access_token'];
//
//  LocalStorageService.instance.set(EndPoints.accessTokenKey, token);

