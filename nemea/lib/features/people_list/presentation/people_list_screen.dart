import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemea/core/dependency_injection.dart';
import 'package:nemea/features/home/domain/repositories/home_repository.dart';
import 'package:nemea/features/people_list/presentation/bloc/user/user_bloc.dart';
import 'package:nemea/features/people_list/presentation/screens/login_screen.dart';
import 'package:nemea/features/people_list/presentation/screens/people_screen.dart';
import 'package:nemea/utils/helpers/another_flushbar_helper.dart';

class PeopleListScreen extends StatelessWidget {
  const PeopleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: sl<UserBloc>()..add(GetUserEvent()),
      builder: (context, state) {
        switch (state.runtimeType) {
          case UserInitial || Unauthenticated || UserLoading:
            return LoginScreen();
          case UserAuthenticated:
            return PeopleScreen();
          default:
            return Scaffold();
        }
      },
      listener: (BuildContext context, UserState state) {
        if (state is Unauthenticated) {
          if (state.message.isNotEmpty) {
            AnotherFlushbarHelper.createError(
              message: state.message,
            )..show(context);
          }
        }
        if (state is UserAuthenticated) {
          sl<HomeRepository>().postFcm();
        }
      },
    );
  }
}
