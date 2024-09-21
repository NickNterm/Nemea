import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'fwi_event.dart';
part 'fwi_state.dart';

class FwiBloc extends Bloc<FwiEvent, FwiState> {
  final HomeRepository homeRepository;
  FwiBloc({required this.homeRepository}) : super(FwiInitial()) {
    on<GetFwi>(_onGetFwi);
  }

  _onGetFwi(GetFwi event, Emitter<FwiState> emit) async {
    emit(FwiLoading());
    final result = await homeRepository.getFWI();
    result.fold(
      (l) => emit(FwiError()),
      (fwi) => emit(FwiLoaded(fwi)),
    );
  }
}
