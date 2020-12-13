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
  anonimGirisYap() async {
    FirebaseAuth authResult = FirebaseAuth.instance;
    authResult.signInAnonymously().then((value) {
      /*print(value.user.uid);
      print(value.user.displayName);
      print(value.user.email);*/
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
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          User aktifKullanici = snapshot.data;
          print(aktifKullanici.uid);
          return anaSayfa();
        } else {
          return girisSayfasi();
        }
      },
    );
  }
}
