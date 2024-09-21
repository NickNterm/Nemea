part of 'vardies_bloc.dart';

@immutable
sealed class VardiesState {}

final class VardiesInitial extends VardiesState {}

final class VardiesLoading extends VardiesState {}

final class VardiesLoaded extends VardiesState {
  final List<Vardia> vardies;

  VardiesLoaded(this.vardies);
}

final class VardiesError extends VardiesState {}
