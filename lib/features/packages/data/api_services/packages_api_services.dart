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
}

