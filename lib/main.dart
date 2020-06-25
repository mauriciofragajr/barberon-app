import 'package:barberOn/screens/auth/login.dart';
import 'package:barberOn/screens/wrapper.dart';
import 'package:barberOn/store/user.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    final userStore = UserStore();
    return MultiProvider(
      providers: [
        Provider<UserStore>.value(value: userStore)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Wrapper(),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      ),
    );
  }
}

class Store extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (_) {
                if (userStore.firebaseUser != null) {
                  return Text(userStore.firebaseUser.uid);
                } else {
                  return Text('Ninguém logado');
                }
              }),
              RaisedButton(
                child: Text('Login com google'),
                onPressed: () {
                  userStore.loginGoogle();
                },
              ),
              RaisedButton(
                child: Text('Sair'),
                onPressed: () {
                  userStore.logout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
