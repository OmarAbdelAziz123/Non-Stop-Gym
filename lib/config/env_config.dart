import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String baseUrl = dotenv.env["baseUrl"] ?? "https://api.example.com";

  static const bool isDebug = bool.fromEnvironment('DEBUG', defaultValue: true);
}
