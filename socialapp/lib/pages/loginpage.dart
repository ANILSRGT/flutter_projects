import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/pages/forgotmypasswordpage.dart';
import 'package:socialapp/pages/registerpage.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  String email, password;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          _pageElements(),
          _loadingAnimation(),
        ],
      ),
    );
  }

  Widget _loadingAnimation() {
    if (loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox(
        height: 0,
      );
    }
  }

  Widget _pageElements() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 60,
        ),
        children: <Widget>[
          FlutterLogo(
            size: 90,
          ),
          SizedBox(
            height: 80,
          ),
          TextFormField(
            validator: (inputValue) {
              if (inputValue.isEmpty) {
                return "Eposta alanı boş bırakılamaz!";
              } else if (!inputValue.contains("@") || !inputValue.contains(".")) {
                return "Girilen değer eposta formatında olmalı!";
              }
              return null;
            },
            onSaved: (inputValue) => email = inputValue,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Eposta adresinizi girin",
              errorStyle: TextStyle(
                fontSize: 16,
              ),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            validator: (inputValue) {
              if (inputValue.isEmpty) {
                return "Şifre alanı boş bırakılamaz!";
              } else if (inputValue.trim().length < 4) {
                return "Şifre 4 karakterden az olamaz!";
              }
              return null;
            },
            onSaved: (inputValue) => password = inputValue,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Şifrenizi girin",
              errorStyle: TextStyle(
                fontSize: 16,
              ),
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "Hesap Oluştur",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FlatButton(
                  onPressed: _login,
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: Theme.of(context).primaryColorDark,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text("veya"),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: _loginWithGoogle,
              child: Text(
                "Google İle Giriş Yap",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotMyPasswordPage()));
              },
              child: Text("Şifremi Unuttum"),
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    final _authorizationService = Provider.of<SAuthorizationService>(context, listen: false);
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        loading = true;
      });

      try {
        await _authorizationService.singInWithEmail(email, password);
      } catch (error) {
        setState(() {
          loading = false;
        });
        showWarning(error.code);
      }
    }
  }

  void _loginWithGoogle() async {
    final _authorizationService = Provider.of<SAuthorizationService>(context, listen: false);

    try {
      MUsers user = await _authorizationService.loginWithGoogle();
      if (user != null) {
        MUsers firestoreUser = await SFireStoreService().getUser(user.id);
        if (firestoreUser == null) {
          SFireStoreService().createUser(
            id: user.id,
            email: user.email,
            username: user.username,
            photoUrl: user.photoUrl,
          );
        }
      }

      setState(() {
        loading = true;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      showWarning(error.code);
    }
  }

  showWarning(errorCode) {
    String errorMessage;

    if (errorCode == "invalid-email") {
      errorMessage = "Eposta adresi geçerli değil!";
    } else if (errorCode == "user-disabled") {
      errorMessage = "Kullanıcı devre dışı bırakıldı!";
    } else if (errorCode == "user-not-found") {
      errorMessage = "Kullanıcı bulunamadı!";
    } else if (errorCode == "wrong-password") {
      errorMessage = "Parola hatalı!";
    } else if (errorCode == "account-exists-with-different-credential") {
      errorMessage = "Eposta adresine sahip bir hesap zaten var!";
    } else if (errorCode == "invalid-credential") {
      errorMessage = "Kimlik bilgisi geçersiz veya süresi dolmuş!";
    } else if (errorCode == "operation-not-allowed") {
      errorMessage = "Kimlik bilgisine sahip hesap etkinleştirilmemiş!";
    } else if (errorCode == "invalid-verification-code") {
      errorMessage = "Geçersiz doğrulama kodu!";
    } else if (errorCode == "invalid-verification-id") {
      errorMessage = "Geçersiz doğrulama kimliği!";
    } else {
      errorMessage = "Bilinmeyen bir nedenden dolayı hata oluştu!";
    }

    var snackBar = SnackBar(
      content: Text(errorMessage),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
