import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get googleServerClientId => dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? "";
}
