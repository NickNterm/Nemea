import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/amea.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'amea_event.dart';
part 'amea_state.dart';

class AmeaBloc extends Bloc<AmeaEvent, AmeaState> {
  final HomeRepository repository;
  AmeaBloc({
    required this.repository,
  }) : super(AmeaInitial()) {
    on<GetAmea>(_onGetAmea);
  }

  _onGetAmea(GetAmea event, Emitter<AmeaState> emit) async {
    emit(AmeaLoading());
    final result = await repository.getAmeas();
    result.fold(
      (failure) => emit(AmeaError()),
      (ameas) => emit(AmeaLoaded(ameas)),
    );
  }
}
