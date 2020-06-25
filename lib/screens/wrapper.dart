import 'package:barberOn/screens/auth/login.dart';
import 'package:barberOn/screens/home.dart';
import 'package:barberOn/store/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userStore = Provider.of<UserStore>(context);

    return Observer(builder: (_) {
      if (userStore.firebaseUser == null) {
        return LoginPage();
      } else {
        return HomePage();
      }
    });
  }
}
