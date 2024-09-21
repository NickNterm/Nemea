part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserLoginEvent extends UserEvent {
  final String email;
  final String password;

  UserLoginEvent({
    required this.email,
    required this.password,
  });
}

class UserLogoutEvent extends UserEvent {}

class GetUserEvent extends UserEvent {}
