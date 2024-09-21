part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserAuthenticated extends UserState {
  final NemeaUser user;

  UserAuthenticated({
    required this.user,
  });
}

class Unauthenticated extends UserState {
  final String message;

  Unauthenticated({
    required this.message,
  });
}
