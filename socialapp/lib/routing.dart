import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/homepage.dart';
import 'package:socialapp/pages/loginpage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';

class Routing extends StatelessWidget {
  const Routing({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authorizationService = Provider.of<SAuthorizationService>(context, listen: false);

    return StreamBuilder(
      stream: _authorizationService.statusTracker,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          MUsers activeUser = snapshot.data;
          _authorizationService.activeUserId = activeUser.id;
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
