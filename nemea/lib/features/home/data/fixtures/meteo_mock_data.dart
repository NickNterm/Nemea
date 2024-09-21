import 'package:nemea/features/home/domain/entities/meteo.dart';

class MeteoMockData {
  static List<Meteo> meteos = [
    meteo1,
    meteo2,
  ];

  static Meteo meteo1 = Meteo(
    name: "nick",
    date: DateTime.now(),
    rh: 0.0,
    temp: 23.2,
    rain: 12,
    solarRadiation: 0,
    solarRadiation2: 1,
    windSpeed: 3.5,
    windDirection: 10,
    windGust: 4.0,
    pressure: 1013.0,
  );

  static Meteo meteo2 = Meteo(
    name: "nick2",
    date: DateTime.now(),
    rh: 0.2,
    temp: 19.1,
    rain: 2,
    solarRadiation: 2,
    solarRadiation2: 3,
    windSpeed: 0.5,
    windDirection: 3,
    windGust: 0.2,
    pressure: 10.0,
  );
}
