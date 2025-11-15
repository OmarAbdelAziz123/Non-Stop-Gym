import 'package:dio/dio.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class PackagesApiServices {
  PackagesApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> fetchSubscriptions() {
    return _dioHelper.get(
      endPoint: EndPoints.getSubscriptions,
    );
  }

  Future<Response?> subscribe({
    required int subscriptionId,
    String paymentMethod = 'cash',
  }) {
    return _dioHelper.post(
      endPoint: EndPoints.subscribe,
      data: {
        'subscription_id': subscriptionId,
        'payment_method': paymentMethod,
      },
    );
  }

  Future<Response?> getUserSubscription() {
    return _dioHelper.get(
      endPoint: EndPoints.getUserSubscription,
    );
  }
}

