// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$WeatherApiService extends WeatherApiService {
  _$WeatherApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = WeatherApiService;

  @override
  Future<Response<dynamic>> getFWI(
    double lat,
    double lon,
  ) {
    final Uri $url = Uri.parse('/fwi');
    final Map<String, dynamic> $params = <String, dynamic>{
      'lat': lat,
      'lon': lon,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
