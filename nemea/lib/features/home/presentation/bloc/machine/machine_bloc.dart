import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/machine.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'machine_event.dart';
part 'machine_state.dart';

class MachineBloc extends Bloc<MachineEvent, MachineState> {
  final HomeRepository repository;
  MachineBloc({
    required this.repository,
  }) : super(MachineInitial()) {
    on<GetMachine>(_onGetMachine);
  }

  _onGetMachine(GetMachine event, Emitter<MachineState> emit) async {
    emit(MachineLoading());
    final result = await repository.getMachines();
    result.fold(
      (failure) => emit(MachineError()),
      (machines) => emit(MachineLoaded(machines)),
    );
  }
}
