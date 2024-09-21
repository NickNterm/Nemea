part of 'meteo_bloc.dart';

@immutable
abstract class MeteoState {}

class MeteoInitial extends MeteoState {}

class MeteoLoading extends MeteoState {}

class MeteoLoaded extends MeteoState {
  final List<Meteo> meteos;

  MeteoLoaded(this.meteos);
}

class MeteoError extends MeteoState {}
