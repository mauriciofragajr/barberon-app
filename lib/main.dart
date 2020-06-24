import 'package:barberOn/services/auth.dart';
import 'package:barberOn/store/user.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:barberOn/screens/wrapper.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

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
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Wrapper(),
        // home: Store(),
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
      ),
    );
  }
}

class Store extends StatelessWidget {
  final userStore = UserStore();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Observer(builder: (_) {
                if (userStore.user != null) {
                  return Text(userStore.user.uid);
                } else {
                  return Text('Ninguém logado');
                }
              }),
              RaisedButton(
                child: Text('Alterar usuario'),
                onPressed: () {
                  userStore.setUser('123456');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
