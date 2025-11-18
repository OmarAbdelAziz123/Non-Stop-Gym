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

  Future<Response?> getAvailableBookingSlots(String date) {
    return _dioHelper.post(
      endPoint: EndPoints.getAvailableBookingSlots,
      data: {'date': date},
    );
  }

  Future<Response?> bookBooking(int bookingDateId) {
    return _dioHelper.post(
      endPoint: EndPoints.bookBooking,
      data: {'booking_date_id': bookingDateId},
    );
  }
}

