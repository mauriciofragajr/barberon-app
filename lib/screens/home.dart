import 'package:barberOn/screens/first_access.dart';
import 'package:barberOn/screens/profile.dart';
import 'package:barberOn/components/loading.dart';
import 'package:barberOn/services/auth.dart';
import 'package:barberOn/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _auth.getProfile(userStore.firebaseUser),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkFirstAcess(context, snapshot.data);
          }
          return Loading();
        },
      ),
    );
  }

  Scaffold returnHome(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.supervised_user_circle),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                        fullscreenDialog: true));
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await userStore.logout();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget checkFirstAcess(BuildContext context, DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FirstAccessPage();
    } else {
      return returnHome(context);
    }
  }
}
