import 'package:barberOn/screens/auth/register.dart';
import 'package:barberOn/screens/profile.dart';
import 'package:barberOn/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        loading = true;
                        error = '';
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          _email, _password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Usuário ou senha inválida';
                        });
                      }
                    }
                  },
                  child: Text('Entrar'),
                ),
                RaisedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                      error = '';
                    });
                    dynamic result = await _auth.signInWithGoogle();
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = 'Usuário ou senha inválida';
                      });
                    }
                  },
                  child: Text('Login com google'),
                ),
                RaisedButton(
                  onPressed: _navigateToRegisterPage,
                  child: Text('Cadastrar'),
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _navigateToRegisterPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}
