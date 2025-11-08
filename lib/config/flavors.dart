import 'package:non_stop/config/env_config.dart';

enum Flavor { dev, prod }

class AppFlavor {
  static Flavor appFlavor = Flavor.dev;

  static String get baseUrl => switch (appFlavor) {
    Flavor.prod => EnvConfig.baseUrl,
    Flavor.dev => EnvConfig.baseUrl,
  };
}
