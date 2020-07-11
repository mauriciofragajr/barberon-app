// import 'package:barberOn/app/screens/home/home_controller.dart';
import 'package:barberOn/app/stores/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authStore = Provider.of<AuthStore>(context);
    // final _controller = HomeController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Barberon'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new),
            tooltip: 'Sair',
            onPressed: () => _authStore.signOut(),
          )
        ],
      ),
    );
  }
}
