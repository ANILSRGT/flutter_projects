import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Hesap Oluştur"),
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
                        return "Kullanıcı adı alanı boş bırakılamaz!";
                      } else if (inputValue.trim().length < 6 || inputValue.trim().length > 12) {
                        return "Girilen değer 6-12 karakter uzunluğunda olmalı!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => username = inputValue,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: "Kullanıcı adınızı girin",
                      labelText: "Kullanıcı Adı:",
                      errorStyle: TextStyle(
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                    height: 10,
                  ),
                  TextFormField(
                    validator: (inputValue) {
                      if (inputValue.isEmpty) {
                        return "Şifre alanı boş bırakılamaz!";
                      } else if (inputValue.trim().length < 6) {
                        return "Şifre 6 karakterden az olamaz!";
                      }
                      return null;
                    },
                    onSaved: (inputValue) => password = inputValue,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Şifrenizi girin",
                      labelText: "Şifre:",
                      errorStyle: TextStyle(
                        fontSize: 16,
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: double.infinity,
                    child: FlatButton(
                      onPressed: _createUser,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createUser() async {
    final _authorizationService = Provider.of<SAuthorizationService>(context, listen: false);

    var _formState = _formKey.currentState;

    if (_formState.validate()) {
      _formState.save();
      setState(() {
        loading = true;
      });

      try {
        MUsers user = await _authorizationService.registerWithEmail(email, password);
        if (user != null) {
          SFireStoreService().createUser(
            id: user.id,
            email: email,
            username: username,
          );
        }
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
      case "operation-not-allowed":
        errorMessage = "Kullanıcı devre dışı bırakıldı!";
        break;
      case "weak-password":
        errorMessage = "Eposta ile giriş devre dışı bırakıldı!";
        break;
      case "email-already-in-use":
        errorMessage = "Parola yeterince güçlü değil!";
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
