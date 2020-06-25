import 'package:barberOn/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'user.g.dart';

class UserStore = _UserStoreBase with _$UserStore;

abstract class _UserStoreBase with Store {
  final AuthService _auth = AuthService();

  _UserStoreBase() {
    var subscription = _auth.firebaseUser.asObservable();
    subscription.listen((user) {
      firebaseUser = user;
    });
  }
  @observable
  FirebaseUser firebaseUser;

  @observable
  int counter = 0;

  @action
  void addCounter() {
    counter++;
  }

  @action
  Stream<FirebaseUser> authChanges() {
    return _auth.firebaseUser;
  }

  @action
  Future<String> loginGoogle() async {
    try {
      var result = await _auth.signInWithGoogle();
      return result;
    } catch (e) {
      print('Erro não tratado' + e.toString());
      return 'Erro na solicitação. Tente novamente.';
    }
  }

  @action
  Future<String> logout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Erro não tratado' + e.toString());
      return 'Erro na solicitação. Tente novamente.';
    }
  }
}
