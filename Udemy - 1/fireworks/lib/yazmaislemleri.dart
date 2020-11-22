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

  kullaniciEkle() {
    db
        .collection("kullanicilar")
        .add({
          "isim": "Hakan",
          "soyad": "Demir",
          "mail": "hdemir@mailim.com",
          "avatar": "https://cdn.pixabay.com/photo/2017/01/03/01/38/man-1948310__340.jpg",
        })
        .then((makbuz) => print(makbuz.id))
        .catchError((hata) {
          print("Kullanıcı eklemede hata oluştu: $hata");
        });
  }

  kimlikIlekullaniciEkle() {
    db
        .collection("kullanicilar")
        .doc("abc")
        .set({
          "isim": "Hakan",
          "soyad": "Demir",
          "mail": "hdemir@mailim.com",
          "avatar": "https://cdn.pixabay.com/photo/2017/01/03/01/38/man-1948310__340.jpg",
        })
        .then((_) => print("Döküman girildi!"))
        .catchError((hata) {
          print("Kullanıcı eklemede hata oluştu: $hata");
        });
  }

  kullaniciGuncelle() {
    db
        .collection("kullanicilar")
        .doc("lDOt43IDTE66x7ConQGh")
        .update({
          "isim": "Zeynep",
          "soyad": "Tunç",
          "mail": "ztunc@mailim.com",
          "avatar": "https://cdn.pixabay.com/photo/2015/03/03/08/55/portrait-657116_960_720.jpg",
        })
        .then((_) => print("Döküman girildi!"))
        .catchError((hata) {
          print("Hata oluştu: $hata");
        });
  }

  kullaniciSil() {
    db
        .collection("kullanicilar")
        .doc("dEnkRhTHlJV5rE5lRURs")
        .delete()
        .then((_) => print("Döküman girildi!"))
        .catchError((hata) {
      print("Hata oluştu: $hata");
    });
  }

  @override
  void initState() {
    super.initState();
    kullaniciSil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("kullanicilar").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Kullanici> kullanicilar =
              snapshot.data.docs.map((element) => Kullanici.dokumandanUret(element)).toList();

          return ListView.builder(
            itemCount: kullanicilar.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(kullanicilar[index].isim),
                subtitle: Text(kullanicilar[index].eposta),
                leading: Image.network(
                  kullanicilar[index].avatar,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
