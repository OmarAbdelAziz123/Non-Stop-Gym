import 'package:dio/dio.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class NotificationApiServices {
  NotificationApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> getNotifications({
    int perPage = 15,
    int page = 1,
  }) {
    return _dioHelper.get(
      endPoint: EndPoints.getNotifications,
      data: {
        'per_page': perPage,
        'page': page,
      },
    );
  }

  Future<Response?> deleteAllNotifications() {
    return _dioHelper.delete(
      endPoint: EndPoints.deleteAllNotifications,
    );
  }

  Future<Response?> markAllNotificationsAsRead() {
    return _dioHelper.post(
      endPoint: EndPoints.markAllNotificationsRead,
    );
  }
}

