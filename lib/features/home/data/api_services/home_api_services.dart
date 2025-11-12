import 'package:dio/dio.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/endpoints.dart';

class HomeApiServices {
  HomeApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> fetchBanners() {
    return _dioHelper.get(
      endPoint: EndPoints.getBanners,
    );
  }

  Future<Response?> fetchSettings() {
    return _dioHelper.get(
      endPoint: EndPoints.getSettings,
    );
  }
}

