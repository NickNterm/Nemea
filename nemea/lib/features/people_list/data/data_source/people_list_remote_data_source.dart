import 'package:firebase_auth/firebase_auth.dart';
import 'package:nemea/features/people_list/domain/entities/nemea_user.dart';

abstract class PeopleListRemoteDataSource {
  Future<NemeaUser> getUser();

  Future<NemeaUser> login(String email, String password);

  Future<void> logout();
}

class PeopleListRemoteDataSourceImpl implements PeopleListRemoteDataSource {
  final FirebaseAuth auth;

  PeopleListRemoteDataSourceImpl(this.auth);
  @override
  Future<NemeaUser> getUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      return NemeaUser(
        uid: user.uid,
        email: user.email!,
      );
    } else {
      throw Exception();
    }
  }

  @override
  Future<NemeaUser> login(String email, String password) async {
    var user =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return NemeaUser(
      uid: user.user!.uid,
      email: user.user!.email!,
    );
  }

  @override
  Future<void> logout() {
    return auth.signOut();
  }
}
