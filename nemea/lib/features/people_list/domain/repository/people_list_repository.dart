import 'package:nemea/features/people_list/domain/entities/nemea_user.dart';
import 'package:nemea/utils/either_typedef.dart';

abstract class PeopleListRepository {
  FutureEither<NemeaUser> getUser();

  FutureEither<NemeaUser> login(String email, String password);

  FutureEither<void> logout();
}
