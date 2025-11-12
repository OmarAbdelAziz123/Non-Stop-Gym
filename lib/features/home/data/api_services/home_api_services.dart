import 'package:dio/dio.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/core/network/dio_helper/end_points.dart'
    as dio_endpoints;
import 'package:non_stop/core/network/endpoints.dart';

class HomeApiServices {
  HomeApiServices(this._dioHelper);

  final DioHelper _dioHelper;

  Future<Response?> fetchBanners() {
    return _dioHelper.get(
      endPoint: EndPoints.getBanners,
    );
  }
}

