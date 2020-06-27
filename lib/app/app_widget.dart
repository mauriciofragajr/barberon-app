import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:provider/provider.dart';

import 'package:barberOn/app/stores/auth_store.dart';
import 'package:barberOn/app/screens/home/home_screen.dart';
import 'package:barberOn/app/screens/login/login_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Observer(builder: (_) {
      print('User Logged In: ' + authStore.isLoggedIn.toString());
      if (authStore.isLoggedIn) {
        return HomeScreen();
      } else {
        return LoginScreen();
      }
    });
  }
}
