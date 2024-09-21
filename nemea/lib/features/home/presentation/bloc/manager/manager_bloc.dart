import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/manager.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'manager_event.dart';
part 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  final HomeRepository repository;
  ManagerBloc({
    required this.repository,
  }) : super(ManagerInitial()) {
    on<GetManager>(_onGetManager);
  }

  _onGetManager(GetManager event, Emitter<ManagerState> emit) async {
    emit(ManagerLoading());
    final result = await repository.getManagers();
    result.fold(
      (failure) => emit(ManagerError()),
      (managers) => emit(ManagerLoaded(managers)),
    );
  }
}
