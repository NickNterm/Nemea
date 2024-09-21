part of 'warnings_bloc.dart';

@immutable
abstract class WarningsState {}

class WarningsInitial extends WarningsState {}

class WarningsLoading extends WarningsState {}

class WarningsLoaded extends WarningsState {
  final List<Warning> warnings;

  WarningsLoaded({
    required this.warnings,
  });
}

class WarningsError extends WarningsState {
  final String message;

  WarningsError({
    required this.message,
  });
}
