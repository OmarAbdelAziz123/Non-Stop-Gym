import 'package:get_it/get_it.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  /// Shared DI
  /// Dio
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  // getIt.registerLazySingleton<AuthApiServices>(() => AuthApiServices(getIt()));

  // getIt.registerLazySingleton<MyBookingRepos>(() => MyBookingRepos(getIt()));
}
