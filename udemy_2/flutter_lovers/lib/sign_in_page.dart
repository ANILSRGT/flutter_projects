import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widgets/social_log_in_button.dart';
import 'package:flutter_lovers/models/muser.dart';
import 'package:flutter_lovers/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _misafirGirisi(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    MUser _user = await _userModel.signInAnonymously();
  }

  void _googleIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    MUser _user = await _userModel.signInWithGoogle();
  }

  void _facebookIleGiris(BuildContext context) async {
    final _userModel = Provider.of<UserModel>(context, listen: false);
    MUser _user = await _userModel.signInWithFacebook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Lovers'),
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Oturum Açın',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            SizedBox(height: 8),
            SocialLoginButton(
              buttonColor: Colors.white,
              buttonText: 'Gmail ile Giriş Yap',
              buttonIcon: Image.asset("images/google-logo.png"),
              textColor: Colors.black,
              onPressed: () => _googleIleGiris(context),
            ),
            SocialLoginButton(
              buttonColor: Color(0xFF334D92),
              buttonText: 'Facebook ile Giriş Yap',
              buttonIcon: Image.asset("images/facebook-logo.png"),
              onPressed: () => _facebookIleGiris(context),
            ),
            SocialLoginButton(
              buttonText: 'Email ve Şifre ile Giriş Yap',
              buttonIcon: Icon(
                Icons.email,
                color: Colors.white,
                size: 32,
              ),
              buttonColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            SocialLoginButton(
              buttonIcon: Icon(
                Icons.supervised_user_circle_outlined,
                color: Colors.white,
                size: 32,
              ),
              buttonText: 'Misafir Girişi',
              buttonColor: Colors.teal,
              onPressed: () => _misafirGirisi(context),
            ),
          ],
        ),
      ),
    );
  }
}
