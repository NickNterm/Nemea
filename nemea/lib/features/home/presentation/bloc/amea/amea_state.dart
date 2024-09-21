part of 'amea_bloc.dart';

@immutable
abstract class AmeaState {}

class AmeaInitial extends AmeaState {}

class AmeaLoading extends AmeaState {}

class AmeaLoaded extends AmeaState {
  final List<Amea> ameas;

  AmeaLoaded(this.ameas);
}

class AmeaError extends AmeaState {}
