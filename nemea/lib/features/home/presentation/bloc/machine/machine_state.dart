part of 'machine_bloc.dart';

@immutable
abstract class MachineState {}

class MachineInitial extends MachineState {}

class MachineLoading extends MachineState {}

class MachineLoaded extends MachineState {
  final List<Machine> machines;

  MachineLoaded(this.machines);
}

class MachineError extends MachineState {}
