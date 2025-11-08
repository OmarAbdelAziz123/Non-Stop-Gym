import 'package:get_it/get_it.dart';
import 'package:non_stop/core/network/api_client.dart';
import 'package:non_stop/core/services/local_storage.dart';
import 'package:non_stop/core/services/notification_service.dart';
import 'package:non_stop/core/theme/theme_cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /// Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  /// Services
  sl.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  sl.registerLazySingleton<NotificationService>(() => NotificationService());

  /// Cubits
  // sl.registerFactory(() => LoginCubit(sl(), sl()));
}
