import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projem',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: YonlendirmeSayfasi(),
    );
  }
}

class YonlendirmeSayfasi extends StatefulWidget {
  @override
  _YonlendirmeSayfasiState createState() => _YonlendirmeSayfasiState();
}

class _YonlendirmeSayfasiState extends State<YonlendirmeSayfasi> {
  bool isAuth = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((kullanici) {
      if (kullanici != null) {
        print("Kullanıcı giriş yapmış durumda, şimdi girş yapmış ya da uygulamayı açmış olabilir.");
        setState(() {
          isAuth = true;
        });
      } else {
        print("Kullanıcı giriş yapmamış, çıkış yapmış ya da uygulamayı yeni açmış olabilir.");
        setState(() {
          isAuth = false;
        });
      }
    });
  }

  anonimGirisYap() async {
    FirebaseAuth authResult = FirebaseAuth.instance;
    authResult.signInAnonymously().then((value) {
      print(value.user.uid);
      print(value.user.displayName);
      print(value.user.email);
    });
  }

  cikisYap() {
    FirebaseAuth.instance.signOut();
  }

  Widget girisSayfasi() {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80,
          width: 120,
          color: Colors.grey,
          child: Center(
            child: InkWell(
              onTap: () => anonimGirisYap(),
              child: Text("Giriş Yap"),
            ),
          ),
        ),
      ),
    );
  }

  Widget anaSayfa() {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => cikisYap(),
          child: Text("Çıkış Yap"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? anaSayfa() : girisSayfasi();
  }
}
