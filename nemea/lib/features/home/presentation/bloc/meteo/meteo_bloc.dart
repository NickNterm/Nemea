import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/meteo.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'meteo_event.dart';
part 'meteo_state.dart';

class MeteoBloc extends Bloc<MeteoEvent, MeteoState> {
  final HomeRepository repository;
  MeteoBloc({
    required this.repository,
  }) : super(MeteoInitial()) {
    on<GetMeteo>(_onGetMeteo);
  }

  _onGetMeteo(GetMeteo event, Emitter<MeteoState> emit) async {
    emit(MeteoLoading());

    try {
      await repository.getMeteo();

      await Future.delayed(Duration(seconds: 2));
      await emit.forEach<List<Meteo>>(
        repository.$meteos,
        onData: (meteos) {
          return MeteoLoaded(meteos);
        },
        onError: (e, st) => MeteoError(),
      );
    } catch (_) {
      emit(MeteoError());
    }
  }
}
