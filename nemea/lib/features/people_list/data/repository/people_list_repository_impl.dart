import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemea/core/errors/failures.dart';
import 'package:nemea/features/people_list/data/data_source/people_list_remote_data_source.dart';
import 'package:nemea/features/people_list/domain/entities/nemea_user.dart';
import 'package:nemea/features/people_list/domain/repository/people_list_repository.dart';
import 'package:nemea/utils/either_typedef.dart';

class PeopleListRepositoryImpl implements PeopleListRepository {
  final PeopleListRemoteDataSource remoteDataSource;

  PeopleListRepositoryImpl(this.remoteDataSource);
  @override
  FutureEither<NemeaUser> getUser() async {
    try {
      final user = await remoteDataSource.getUser();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<NemeaUser> login(String email, String password) async {
    try {
      final user = await remoteDataSource.login(email, password);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticationFailure(message: e.message!));
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  FutureEither<void> logout() async {
    try {
      await remoteDataSource.logout();
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
