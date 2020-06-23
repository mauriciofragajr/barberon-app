import 'package:barberOn/models/user.dart';
import 'package:barberOn/screens/logged/first_access.dart';
import 'package:barberOn/screens/logged/profile.dart';
import 'package:barberOn/screens/shared/loading.dart';
import 'package:barberOn/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.user}) : super(key: key);

  final User user;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final User user = widget.user;

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _auth.getProfile(user),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return checkFirstAcess(snapshot.data);
          }
          return Loading();
        },
      ),
    );
  }

  Scaffold returnHome() {
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
                await _auth.signOut();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget checkFirstAcess(DocumentSnapshot snapshot) {
    if (snapshot.data == null) {
      return FirstAccessPage();
    } else {
      return returnHome();
    }
  }
}
