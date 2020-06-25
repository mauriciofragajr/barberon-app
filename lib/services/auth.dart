import 'package:barberOn/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  Stream<FirebaseUser> get firebaseUser {
    return _auth.onAuthStateChanged;
  }

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      return null;
    } on PlatformException catch (e) {
      print(e);
      switch (e.message) {
        case 'The email address is badly formatted.':
          return 'E-mail inválido.';
          break;
        default:
          print('Erro ${e.message} não foi tratado.');
          return 'Erro ao fazer login. Tente novamente.';
      }
    }
  }

  // sign in with email and password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return null;
    } on PlatformException catch (e) {
      print(e);
      switch (e.message) {
        case 'The email address is badly formatted.':
          return 'E-mail inválido.';
          break;
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'Usuário não encontrado no sistema';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'A senha está inválida ou o usuário não possui uma conta.';
          break;
        default:
          print('Erro ${e.message} não foi tratado.');
          return 'Erro ao fazer login. Tente novamente.';
      }
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // send email verification
      await user.sendEmailVerification();
      // create a new document for the user with the uid
      // await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return null;
    } on PlatformException catch (e) {
      print(e);
      switch (e.message) {
        case 'The email address is badly formatted.':
          return 'E-mail inválido.';
          break;
        case 'The email address is already in use by another account.':
          return 'Este e-mail já está sendo utilizado em nosso sistema.';
          break;
        default:
          print('Erro ${e.message} não foi tratado.');
          return 'Erro ao fazer login. Tente novamente.';
      }
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Stream<DocumentSnapshot> getProfile(FirebaseUser user) {
    return Firestore.instance
        .collection('users')
        .document(user.uid)
        .snapshots();
  }
}
