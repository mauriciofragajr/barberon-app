import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
              onPressed: () {},
              child: Text('Cadastrar'),
            )
          ],
        ),
      ),
    );
  }
}
