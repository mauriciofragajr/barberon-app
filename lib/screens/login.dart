import 'package:barberOn/screens/profile.dart';
import 'package:barberOn/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              onPressed: signIn,
              child: Text('Entrar'),
            ),
            RaisedButton(
              onPressed: navigateToRegisterPage,
              child: Text('Cadastrar'),
            ),
            // Text('Esqueci minha senha')
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
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

  void navigateToRegisterPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(
                  title: 'Cadastrar',
                )));
  }
}
