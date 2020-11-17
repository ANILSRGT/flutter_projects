import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/services/s_authorizationservice.dart';

class ForgotMyPasswordPage extends StatefulWidget {
  @override
  _ForgotMyPasswordPageState createState() => _ForgotMyPasswordPageState();
}

class _ForgotMyPasswordPageState extends State<ForgotMyPasswordPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Şifre Sıfırla"),
      ),
      body: ListView(
        children: <Widget>[
          loading ? LinearProgressIndicator() : SizedBox(height: 0),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
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
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Eposta adresinizi girin",
                      labelText: "Eposta:",
                      errorStyle: TextStyle(
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _resetPassword,
                      child: Text(
                        "Şifremi Sıfırla",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetPassword() async {
    final _authorizationService = Provider.of<SAuthorizationService>(context, listen: false);

    var _formState = _formKey.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });

      try {
        await _authorizationService.resetPassword(email);
        Navigator.pop(context);
      } catch (error) {
        setState(() {
          loading = false;
        });
        showWarning(error.code);
      }
    }
  }

  showWarning(errorCode) {
    String errorMessage;

    switch (errorCode) {
      case "invalid-email":
        errorMessage = "Eposta adresi geçerli değil!";
        break;
      case "user-disabled":
        errorMessage = "Kullanıcı devre dışı bırakıldı!";
        break;
      case "user-not-found":
        errorMessage = "Kullanıcı bulunamadı!";
        break;
      case "wrong-password":
        errorMessage = "Verilen e-posta için şifre geçersiz veya e-postaya daha önce bir şifre belirlenmemiş!";
        break;
      default:
        errorMessage = "Bilinmeyen bir nedenden dolayı hata oluştu!";
    }

    var snackBar = SnackBar(
      content: Text(errorMessage),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
