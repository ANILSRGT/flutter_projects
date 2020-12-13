import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {
  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('Kullanıcı oturumunu kapattı veya yok');
      } else {
        if (user.emailVerified) {
          print('Kullanıcı oturum açtı ve emaili onaylı');
        } else {
          print('Kullanıcı oturum açtı ve emaili onaylı değil');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login İşlemleri"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Email/Şifre User Create"),
              color: Colors.blueAccent,
              onPressed: _emailSifreKullaniciOlustur,
            ),
            RaisedButton(
              child: Text("Email/Şifre User Login"),
              color: Colors.blueAccent,
              onPressed: _emailSifreKullaniciGirisYap,
            ),
            RaisedButton(
              child: Text("Şifremi Unuttum"),
              color: Colors.blueAccent,
              onPressed: _resetPassword,
            ),
            RaisedButton(
              child: Text("Şifremi Güncelle"),
              color: Colors.blueAccent,
              onPressed: _updatePassword,
            ),
            RaisedButton(
              child: Text("Emailimi Güncelle"),
              color: Colors.blueAccent,
              onPressed: _updateEmail,
            ),
            RaisedButton(
              child: Text("Google İle Giriş"),
              color: Colors.blueAccent,
              onPressed: _googleIleGiris,
            ),
            RaisedButton(
              child: Text("Telefon İle Giriş"),
              color: Colors.blueAccent,
              onPressed: _telefonlaGiris,
            ),
            RaisedButton(
              child: Text("Çıkış Yap"),
              color: Colors.blueAccent,
              onPressed: _cikisYap,
            ),
          ],
        ),
      ),
    );
  }

  void _telefonlaGiris() async {
    String testPhoneNumber = '+90 554 712 47 27'; // code : 123456

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: testPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Sign the user in (or link) with the auto-generated credential
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("HATA : $e");
      },
      codeSent: (String verificationId, int resendToken) async {
        debugPrint("Kod yollandı!");
        try {
          String smsCode = '123456';
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
          await _auth.signInWithCredential(phoneAuthCredential);
        } catch (e) {
          debugPrint("HATA : $e");
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint("Kodun geçerlilik zamanı geçti!");
      },
    );
  }

  void _emailSifreKullaniciOlustur() async {
    String _email = "kerel48345@hebgsw.com";
    String _password = "password";

    try {
      UserCredential _userCredential = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
      User _yeniUser = _userCredential.user;
      await _yeniUser.sendEmailVerification();
      if (_auth.currentUser != null) {
        debugPrint("Size bir mail attık lütfen onaylayın");
        await _auth.signOut();
      }
      debugPrint(_yeniUser.toString());
    } catch (e) {
      debugPrint("Hata : $e");
    }
  }

  void _emailSifreKullaniciGirisYap() async {
    String _email = "kerel48345@hebgsw.com";
    String _password = "password";

    try {
      if (_auth.currentUser == null) {
        User user = (await _auth.signInWithEmailAndPassword(email: _email, password: _password)).user;
        if (!user.emailVerified) {
          debugPrint("Lütfen mailinizi onaylayınız!");
          _auth.signOut();
        }
      } else {
        debugPrint("Zaten oturum açık");
      }
    } catch (e) {
      debugPrint("Hata : $e");
    }
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else {
      debugPrint("Oturum açmış kullanıcı yok!");
    }
  }

  void _resetPassword() async {
    String _email = "kerel48345@hebgsw.com";
    try {
      await _auth.sendPasswordResetEmail(email: _email);
      debugPrint("Resetleme maili gönderildi!");
    } catch (e) {
      debugPrint("Hata : $e");
    }
  }

  void _updatePassword() async {
    try {
      await _auth.currentUser.updatePassword("password2");
      debugPrint("Şifreniz güncellendi!");
    } catch (e) {
      try {
        String _email = "kerel48345@hebgsw.com";
        String _password = "password";
        EmailAuthCredential _credential = EmailAuthProvider.credential(email: _email, password: _password);
        await _auth.currentUser.reauthenticateWithCredential(_credential);
        await _auth.currentUser.updatePassword("password2");
      } catch (e2) {
        debugPrint("Hata : $e2");
      }
      debugPrint("Hata : $e");
    }
  }

  void _updateEmail() async {
    try {
      await _auth.currentUser.updateEmail("deneme@deneme.com");
      debugPrint("Emailiniz güncellendi!");
    } on FirebaseAuthException catch (e) {
      try {
        String _email = "kerel48345@hebgsw.com";
        String _password = "password";
        EmailAuthCredential _credential = EmailAuthProvider.credential(email: _email, password: _password);
        await _auth.currentUser.reauthenticateWithCredential(_credential);
        await _auth.currentUser.updateEmail("deneme@deneme.com");
      } catch (e2) {
        debugPrint("Hata : $e2");
      }
      debugPrint("Hata : $e");
    }
  }

  Future<UserCredential> _googleIleGiris() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      debugPrint("HATA : $e");
    }
  }
}
