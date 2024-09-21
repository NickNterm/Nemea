import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:nemea/app_config.dart';

const String NEMEA_HEADER = 'Nemea-Api-Key';

class HomeApiInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    final newRequest = request.copyWith(
      headers: {
        ...request.headers,
        NEMEA_HEADER: AppConfig.instance().appApiKey,
      },
    );
    return chain.proceed(newRequest);
  }
}
