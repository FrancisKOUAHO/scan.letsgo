import 'dart:io' show Platform;

class AppUrl {
  static String baseUrl = Platform.isIOS ? 'https://api.letsg0.fr/api/v1' : 'https://api.letsg0.fr/api/v1';
}
