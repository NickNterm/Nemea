import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/features/home/domain/entities/volunteer.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
part 'volunteer_event.dart';
part 'volunteer_state.dart';

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  final HomeRepository repository;
  VolunteerBloc({required this.repository}) : super(VolunteerInitial()) {
    on<GetVolunteer>(_onGetVolunteer);
  }

  _onGetVolunteer(GetVolunteer event, Emitter<VolunteerState> emit) async {
    emit(VolunteerLoading());
    final result = await repository.getVolunteers();
    result.fold(
      (failure) => emit(VolunteerError()),
      (volunteers) => emit(VolunteerLoaded(volunteers)),
    );
  }
}
