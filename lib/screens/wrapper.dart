import 'package:barberOn/models/user.dart';
import 'package:barberOn/screens/auth/authenticate.dart';
import 'package:barberOn/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
