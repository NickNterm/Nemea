part of 'fwi_bloc.dart';

@immutable
abstract class FwiState {}

class FwiInitial extends FwiState {}

class FwiLoading extends FwiState {}

class FwiLoaded extends FwiState {
  final int fwi;

  FwiLoaded(this.fwi);
}

class FwiError extends FwiState {}
