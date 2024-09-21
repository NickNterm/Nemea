import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nemea/features/home/data/models/meteo_model.dart';

part 'meteo.g.dart';

@HiveType(typeId: 0)
class Meteo extends Equatable {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final double rh;

  @HiveField(2)
  final double temp;

  @HiveField(3)
  final double rain;

  @HiveField(4)
  final double solarRadiation;

  @HiveField(5)
  final double solarRadiation2;

  @HiveField(6)
  final double windSpeed;

  @HiveField(7)
  final double windDirection;

  @HiveField(8)
  final double windGust;

  @HiveField(9)
  final double pressure;

  @HiveField(10)
  final String name;

  Meteo({
    required this.name,
    required this.date,
    required this.rh,
    required this.temp,
    required this.rain,
    required this.solarRadiation,
    required this.solarRadiation2,
    required this.windSpeed,
    required this.windDirection,
    required this.windGust,
    required this.pressure,
  });

  static List<Meteo> fromModelList(BuiltList<MeteoModel> models) {
    return models.map((model) => Meteo.fromModel(model)).toList();
  }

  factory Meteo.empty() {
    return Meteo(
      name: '',
      date: DateTime.now(),
      rh: 0,
      temp: 0,
      rain: 0,
      solarRadiation: 0,
      solarRadiation2: 0,
      windSpeed: 0,
      windGust: 0,
      windDirection: 0,
      pressure: 0,
    );
  }
  factory Meteo.fromModel(MeteoModel model) {
    return Meteo(
      name: model.name,
      date: DateTime.parse(model.datetime),
      rh: model.rh,
      temp: model.temp,
      rain: model.rain,
      solarRadiation: model.solarRadiation,
      solarRadiation2: model.solarRadiation2,
      windSpeed: model.windSpeed,
      windDirection: model.windDirection,
      windGust: model.windGust ?? 0,
      pressure: model.pressure,
    );
  }

  @override
  List<Object?> get props => [
        date,
        name,
        rh,
        temp,
        rain,
        solarRadiation2,
        solarRadiation,
        windSpeed,
        windGust,
        windDirection,
        pressure
      ];
}
