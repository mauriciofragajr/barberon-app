import 'package:barberOn/screens/profile.dart';
import 'package:barberOn/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Por favor, digite um e-mail';
                  }
                  return null;
                },
                onSaved: (input) => {_email = input},
                decoration: InputDecoration(labelText: 'E-mail')),
            TextFormField(
              validator: (input) {
                if (input.isEmpty) {
                  return 'Por favor, digite uma senha';
                }
                if (input.length < 6) {
                  return 'Sua senha deve conter no mínimo 6 caracteres';
                }
                return null;
              },
              onSaved: (input) => {_password = input},
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: _signIn,
              child: Text('Entrar'),
            ),
            RaisedButton(
              onPressed: _signInGoogle,
              child: Text('Login com google'),
            ),
            RaisedButton(
              onPressed: _navigateToRegisterPage,
              child: Text('Cadastrar'),
            ),
            // Text('Esqueci minha senha')
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        print(result.user.isEmailVerified);
        if (result.user.isEmailVerified) {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProfilePage(), fullscreenDialog: true));
        } else {
          print('Favor, verificar seu E-mail!');
        }
      } catch (e) {
        print(e.message);
      }
    } else {
      print('invalid form');
    }
  }

  void _navigateToRegisterPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(
                  title: 'Cadastrar',
                )));
  }

  Future<FirebaseUser> _signInGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return user;
    } catch (e) {
      print(e.message);
      return null;
    }
  }
}
