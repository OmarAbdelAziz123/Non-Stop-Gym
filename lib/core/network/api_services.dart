
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'api_services.g.dart';

@RestApi()
abstract class ApiServices {
  factory ApiServices(Dio dio) = _ApiServices;

  // @POST(EndPoints.login)
  // Future<LoginRequest> login(LoginRequest loginRequest);
  //
  // @MultiPart()
  // @POST(EndPoints.register)
  // Future<LoginRequest> register(
  //   @Part() String name,
  //   @Part() String email,
  //   @Part() String password,
  //   @Part() String phone,
  //   @Part() String address,
  //   @Part() String city,
  //   @Part() String country,
  //   @Part() String zipCode,
  //   @Part() String state,
  //   @Part() String avatar,
  //   @Part() File file,
  // );
}