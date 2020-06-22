import 'package:barberOn/services/auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password, _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String error = '';
  bool loading = false;

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
              onSaved: (input) => {_confirmPassword = input},
              decoration: InputDecoration(labelText: 'Confirmar senha'),
              obscureText: true,
            ),
            RaisedButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  if (_password != _confirmPassword) {
                    setState(() {
                      error = 'Senhas não coincidem';
                    });
                    return;
                  }
                  setState(() {
                    loading = true;
                    error = '';
                  });
                  dynamic result =
                      await _auth.registerWithEmailAndPassword(_email, _password);
                  if (result == null) {
                    setState(() {
                      loading = false;
                      error = 'Não foi possível criar a conta';
                    });
                  }
                }
              },
              child: Text('Cadastrar'),
            ),
            RaisedButton(
              onPressed: () => widget.toggleView(),
              child: Text('Voltar'),
            ),
            SizedBox(height: 12.0),
            Text(
              error,
              style: TextStyle(color: Colors.white, fontSize: 14.0),
            )
          ],
        ),
      ),
    );
  }
}
