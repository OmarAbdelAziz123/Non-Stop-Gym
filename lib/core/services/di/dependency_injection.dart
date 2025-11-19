import 'package:get_it/get_it.dart';
import 'package:non_stop/core/network/dio_helper/dio_helper.dart';
import 'package:non_stop/features/auth/data/api_services/auth_api_services.dart';
import 'package:non_stop/features/auth/data/repos/auth_repository.dart';
import 'package:non_stop/features/home/data/api_services/home_api_services.dart';
import 'package:non_stop/features/home/data/repos/home_repository.dart';
import 'package:non_stop/features/profile/data/api_services/profile_api_services.dart';
import 'package:non_stop/features/profile/data/repos/profile_repository.dart';
import 'package:non_stop/features/packages/data/api_services/packages_api_services.dart';
import 'package:non_stop/features/packages/data/repos/packages_repository.dart';
import 'package:non_stop/features/photo gallery/data/api_services/gallery_api_services.dart';
import 'package:non_stop/features/photo gallery/data/repos/gallery_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  /// Shared DI
  /// Dio
  getIt.registerLazySingleton<DioHelper>(() => DioHelper());

  getIt.registerLazySingleton<AuthApiServices>(
    () => AuthApiServices(getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt()),
  );

  getIt.registerLazySingleton<ProfileApiServices>(
    () => ProfileApiServices(getIt()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepository(getIt()),
  );

  getIt.registerLazySingleton<HomeApiServices>(
    () => HomeApiServices(getIt()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt()),
  );

  getIt.registerLazySingleton<PackagesApiServices>(
    () => PackagesApiServices(getIt()),
  );

  getIt.registerLazySingleton<PackagesRepository>(
    () => PackagesRepository(getIt()),
  );

  getIt.registerLazySingleton<GalleryApiServices>(
    () => GalleryApiServices(getIt()),
  );

  getIt.registerLazySingleton<GalleryRepository>(
    () => GalleryRepository(getIt()),
  );

  // getIt.registerLazySingleton<MyBookingRepos>(() => MyBookingRepos(getIt()));
}
