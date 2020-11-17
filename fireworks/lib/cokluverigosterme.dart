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

  Future<List<Kullanici>> kullanicilariGetir() {
    Future<QuerySnapshot> snapshot = db.collection("kullanicilar").get();
    Future<List<Kullanici>> kullanicilar =
        snapshot.then((value) => value.docs.map((element) => Kullanici.dokumandanUret(element)).toList());
    return kullanicilar;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Kullanici>>(
        future: kullanicilariGetir(),
        builder: (BuildContext context, AsyncSnapshot<List<Kullanici>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].isim),
                subtitle: Text(snapshot.data[index].eposta),
                leading: Image.network(
                  snapshot.data[index].avatar,
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
