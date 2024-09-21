part of 'manager_bloc.dart';

@immutable
abstract class ManagerState {}

class ManagerInitial extends ManagerState {}

class ManagerLoading extends ManagerState {}

class ManagerLoaded extends ManagerState {
  final List<Manager> managers;

  ManagerLoaded(this.managers);
}

class ManagerError extends ManagerState {}
