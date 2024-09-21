part of 'volunteer_bloc.dart';

@immutable
abstract class VolunteerState {}

class VolunteerInitial extends VolunteerState {}

class VolunteerLoading extends VolunteerState {}

class VolunteerLoaded extends VolunteerState {
  final List<Volunteer> volunteer;

  VolunteerLoaded(this.volunteer);
}

class VolunteerError extends VolunteerState {}
