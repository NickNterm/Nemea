library meteo_model;

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meteo_model.g.dart';

abstract class MeteoModel implements Built<MeteoModel, MeteoModelBuilder> {
  MeteoModel._();

  @BuiltValueField(wireName: 'name')
  String get name;

  @BuiltValueField(wireName: 'datetime')
  String get datetime;

  @BuiltValueField(wireName: 'rh')
  double get rh;

  @BuiltValueField(wireName: 'temp')
  double get temp;

  @BuiltValueField(wireName: 'rain')
  double get rain;

  @BuiltValueField(wireName: 'solar_radiation')
  double get solarRadiation;

  @BuiltValueField(wireName: 'solar_radiation2')
  double get solarRadiation2;

  @BuiltValueField(wireName: 'wind_speed')
  double get windSpeed;

  @BuiltValueField(wireName: 'wind_direction')
  double get windDirection;

  @BuiltValueField(wireName: 'wind_gust')
  double? get windGust;

  @BuiltValueField(wireName: 'pressure')
  double get pressure;

  factory MeteoModel([void Function(MeteoModelBuilder) updates]) = _$MeteoModel;

  static Serializer<MeteoModel> get serializer => _$meteoModelSerializer;
}
