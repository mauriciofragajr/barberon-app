import 'package:barberOn/app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final _auth = AuthService();

  _AuthStoreBase() {
    _auth.firebaseUser.listen((newUser) {
      print(newUser);
      user = newUser;
    });
  }

  @observable
  FirebaseUser user;

  @computed
  bool get isLoggedIn => user != null;

  @action
  Future<String> signInWithGoogle() async {
    try {
      return await _auth.signInWithGoogle();
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email, password);
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.registerWithEmailAndPassword(email, password);
    } catch (e) {
      return e.toString();
    }
  }

  @action
  Future<String> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return e.toString();
    }
  }
}
