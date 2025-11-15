/// All API endpoints should be defined here.
/// This keeps your codebase consistent and centralized.
class EndPoints {
  static const String baseUrl = 'https://backend-non-stop-gym.jecdemo.com';

  /// Auth
  static const String login = '/api/frontend/auth/login';
  static const String register = '/api/frontend/auth/register';
  static const String refreshToken = '/api/auth/refresh-token';
  static const String profile = '/api/frontend/profile';
  static const String banners = '/api/frontend/banners';
  static const String forgetPassword = '/api/frontend/auth/forget-password';
  static const String verifyOtp = '/api/frontend/auth/verify-otp';
  static const String resetPassword = '/api/frontend/auth/reset-password';
static const String getBanners = '/api/frontend/banners';
static const String getProfileData = '/api/frontend/profile';
static const String updateProfileData = 'api/user/profile/updateData';
static const String getSettings = '/api/frontend/settings';
  static const String getSubscriptions = '/api/frontend/subscriptions';
  static const String subscribe = '/api/frontend/user-subscriptions/subscribe';
  static const String getUserSubscription = '/api/frontend/user-subscription';
  /// Storage Keys
  static const String accessTokenKey = 'ACCESS_TOKEN';
  static const String refreshTokenKey = 'REFRESH_TOKEN';
  static const String fcmTokenKey = 'FCM_TOKEN';
}


// final token = response.data['access_token'];
//
//  LocalStorageService.instance.set(EndPoints.accessTokenKey, token);

