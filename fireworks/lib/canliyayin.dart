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

  @override
  void initState() {
    super.initState();
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
