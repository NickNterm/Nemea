import 'package:chopper/chopper.dart';
import 'package:nemea/app_config.dart';
import 'package:nemea/core/network/build_value_converter.dart';
import 'package:nemea/features/home/data/network/weather_api_interceptor.dart';
import 'package:nemea/utils/serializers.dart';

part 'weather_api_service.chopper.dart';

@ChopperApi()
abstract class WeatherApiService extends ChopperService {
  @Get(path: '/fwi')
  Future<Response> getFWI(
    @Query('lat') double lat,
    @Query('lon') double lon,
  );

  static WeatherApiService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse(
        AppConfig.instance().weatherEndPoint,
      ),
      services: [
        _$WeatherApiService(),
      ],
      converter: BuiltValueConverter(serializers),
      errorConverter: BuiltValueConverter(serializers),
      interceptors: [
        HttpLoggingInterceptor(),
        WeatherApiInterceptor(),
      ],
    );
    return _$WeatherApiService(client);
  }
}
