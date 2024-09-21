import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:nemea/app_config.dart';

class WeatherApiInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    final newRequest = request.copyWith(
      uri: request.url.replace(
        queryParameters: {
          ...request.url.queryParameters,
          'appid': AppConfig.instance().weatherApiKey,
        },
      ),
    );
    return chain.proceed(newRequest);
  }
}
