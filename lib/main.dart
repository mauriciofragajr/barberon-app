import 'package:barberOn/screens/register.dart';
import 'package:flutter/material.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:barberOn/routes/routes.dart';
import 'package:barberOn/screens/home.dart';
import 'package:barberOn/screens/login.dart';

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
    return MaterialApp(
      title: 'BarberOn',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        Routes.HOME: (_) => HomePage(title: "BarberOn"),
        Routes.LOGIN: (_) => LoginPage(title: "Login"),
        Routes.REGISTER: (_) => RegisterPage(title: "Cadastro")
      },
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
    );
  }
}
