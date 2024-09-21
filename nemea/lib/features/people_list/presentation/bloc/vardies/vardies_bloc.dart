import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/vardia.dart';

import '../../../../home/domain/repositories/home_repository.dart';

part 'vardies_event.dart';

part 'vardies_state.dart';

class VardiesBloc extends Bloc<VardiesEvent, VardiesState> {
  final HomeRepository repository;

  VardiesBloc({required this.repository}) : super(VardiesInitial()) {
    on<GetVardies>(_onGetVardies);
  }

  _onGetVardies(GetVardies event, Emitter<VardiesState> emit) async {
    emit(VardiesLoading());
    try {
      final result = await repository.getVardias();
      result.fold(
        (l) => emit(VardiesError()),
        (r) => emit(VardiesLoaded(r)),
      );
    } catch (e) {
      emit(VardiesError());
    }
  }
}
