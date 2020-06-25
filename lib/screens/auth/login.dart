import 'package:barberOn/components/loading.dart';
import 'package:barberOn/screens/auth/register.dart';
import 'package:barberOn/store/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text('Barberon'),
                ),
                Form(
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
                      Column(
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
                                // String result =
                                //     await _auth.signInWithEmailAndPassword(
                                //         _email, _password);
                                // if (result != null) {
                                //   setState(() {
                                //     loading = false;
                                //     error = result;
                                //   });
                                // }
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
                              String result = await userStore.loginGoogle();
                              if (result != null) {
                                setState(() {
                                  loading = false;
                                  error = result;
                                });
                              }
                            },
                            child: Text('Login com google'),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text('Cadastrar'),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            error,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
  }
}
