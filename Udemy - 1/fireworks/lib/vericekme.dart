import 'package:fireworks/models/kullanici.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  final db = FirebaseFirestore.instance;

  void kullanicilariGetir() async {
    var snapshot = db.collection("kullanicilar").get();
    snapshot.then((value) => value.docs.forEach((element) {
          print(element.data());
        }));
  }

  void kimlikIlekullanicilariGetir() async {
    var doc = db.collection("kullanicilar").doc("2").get();
    doc.then((value) {
      if (value.exists) {
        print(value.data());
      } else {
        print("Döküman bulunamadı!");
      }
    });
  }

  void kullanicilariSirala() async {
    var snapshot = db.collection("kullanicilar").orderBy("yas", descending: true).get();
    snapshot.then((value) => value.docs.forEach((element) {
          print(element.data());
        }));
  }

  void kullaniciSorgula() async {
    Future<QuerySnapshot> snapshot = db.collection("kullanicilar").where("yas", isLessThanOrEqualTo: 60).get();
    snapshot.then((QuerySnapshot value) => value.docs.forEach((QueryDocumentSnapshot element) {
          print(element.data());
        }));
  }

  void kullaniciCokluSorgu() async {
    var snapshot =
        db.collection("kullanicilar").where("soyad", isEqualTo: "Kurt").where("yas", isGreaterThan: 20).limit(1).get();
    snapshot.then((value) => value.docs.forEach((element) {
          print(element.data());
        }));
  }

  void kullaniciOlustur() async {
    var doc = await db.collection("kullanicilar").doc("KjPEEH1GLFxpQprXm9jl").get();
    Kullanici kullanici_1 = Kullanici.dokumandanUret(doc);

    print(kullanici_1.id);
    print(kullanici_1.isim);
    print(kullanici_1.soyad);
    print(kullanici_1.eposta);
    print(kullanici_1.avatar);
  }

  @override
  void initState() {
    super.initState();
    kullaniciOlustur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
