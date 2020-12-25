import 'package:flutter/material.dart';
import 'package:flutter_lovers/models/muser.dart';
import 'package:flutter_lovers/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final MUser user;

  const HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
        actions: [
          FlatButton(
            onPressed: () => _cikisYap(context),
            child: Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Text("Hoşgeldiniz ${widget.user.userID}"),
      ),
    );
  }

  Future<bool> _cikisYap(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    bool sonuc = await _userModel.signOut();
    return sonuc;
  }
}
