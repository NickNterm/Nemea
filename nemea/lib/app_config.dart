import 'package:nemea/core/config/config_prod.dart';

import 'core/config/config_dev.dart';

enum Flavor { dev, prod }

class AppConfig {
  final Flavor flavor;
  final String apiEndPoint;
  final String weatherEndPoint;
  final String weatherApiKey;
  final String appApiKey;

  factory AppConfig({
    required Flavor flavor,
    required String apiEndPoint,
    required String weatherEndPoint,
    required String weatherApiKey,
    required String appApiKey,
  }) =>
      _instance ??= AppConfig._internal(
        flavor,
        apiEndPoint,
        weatherEndPoint,
        weatherApiKey,
        appApiKey,
      );

  AppConfig._internal(
    this.flavor,
    this.apiEndPoint,
    this.weatherEndPoint,
    this.weatherApiKey,
    this.appApiKey,
  );

  static AppConfig? _instance;

  static AppConfig instance() => _instance!;

  static bool isProduction() => _instance!.flavor == Flavor.prod;

  static bool isDevelopment() => _instance!.flavor == Flavor.dev;

  factory AppConfig.dev() => AppConfig(
        flavor: Flavor.dev,
        apiEndPoint: ConfigDev.API_URL,
        weatherEndPoint: ConfigDev.WEATHER_API_URL,
        weatherApiKey: ConfigDev.WEATHER_API_KEY,
        appApiKey: ConfigDev.APP_API_KEY,
      );

  factory AppConfig.prod() => AppConfig(
        flavor: Flavor.prod,
        apiEndPoint: ConfigProd.API_URL,
        weatherEndPoint: ConfigProd.WEATHER_API_URL,
        weatherApiKey: ConfigProd.WEATHER_API_KEY,
        appApiKey: ConfigProd.APP_API_KEY,
      );
}
