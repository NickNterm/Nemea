import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class ConnectivityFailure extends Failure {}

class AuthenticationFailure extends Failure {
  final String message;

  AuthenticationFailure({required this.message});
}
