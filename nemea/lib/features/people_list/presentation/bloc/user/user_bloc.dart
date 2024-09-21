import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nemea/core/errors/failures.dart';
import 'package:nemea/features/people_list/domain/entities/nemea_user.dart';
import 'package:nemea/features/people_list/domain/repository/people_list_repository.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  PeopleListRepository repository;

  UserBloc({
    required this.repository,
  }) : super(UserInitial()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<UserLoginEvent>(_onUserLoginEvent);
    on<UserLogoutEvent>(_onUserLogoutEvent);
  }

  _onGetUserEvent(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    var result = await repository.getUser();

    result.fold(
      (failure) {
        emit(Unauthenticated(message: ''));
      },
      (user) => emit(UserAuthenticated(user: user)),
    );
  }

  _onUserLoginEvent(
    UserLoginEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    var result = await repository.login(event.email, event.password);

    result.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(Unauthenticated(message: 'Server Failure'));
        else if (failure is AuthenticationFailure)
          emit(Unauthenticated(message: failure.message));
      },
      (user) => emit(UserAuthenticated(user: user)),
    );
  }

  _onUserLogoutEvent(
    UserLogoutEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    var result = await repository.logout();

    result.fold(
      (failure) {
        if (failure is ServerFailure)
          emit(Unauthenticated(message: 'Server Failure'));
        else if (failure is AuthenticationFailure)
          emit(Unauthenticated(message: failure.message));
      },
      (_) => emit(UserInitial()),
    );
  }
}
