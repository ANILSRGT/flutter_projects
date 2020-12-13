import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreIslemleri extends StatefulWidget {
  @override
  _FirestoreIslemleriState createState() => _FirestoreIslemleriState();
}

class _FirestoreIslemleriState extends State<FirestoreIslemleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore İşlemleri"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text("Veri Ekle"),
              color: Colors.blueAccent,
              onPressed: _veriEkle,
            ),
          ],
        ),
      ),
    );
  }

  void _veriEkle() {
    Map<String, dynamic> userMap = Map();
    userMap['ad'] = "emre";
    userMap['lisansMezunu'] = true;
    _firestore
        .collection("users")
        .doc('emre_id')
        .set(userMap, SetOptions(merge: true))
        .then((value) => debugPrint("Kullanıcı Eklendi"));
    _firestore.collection("users").doc('hasan_id').set({'ad': 'hasan', 'lisansMezunu': false},
        SetOptions(merge: true)).then((value) => debugPrint("Kullanıcı Eklendi"));
    _firestore.doc("users/ayse_id").set(
        {'ad': 'ayse', 'lisansMezunu': true}, SetOptions(merge: true)).then((value) => debugPrint("Kullanıcı Eklendi"));
    _firestore.collection("users").add({'ad': 'can', 'lisansMezunu': true});
    String yeniKullaniciID = _firestore.collection("users").doc().id;
    debugPrint("Yeni user doc. id : $yeniKullaniciID");
    _firestore
        .doc("users/$yeniKullaniciID")
        .set({"userID": yeniKullaniciID.toString(), 'ad': 'mahmut', 'lisansMezunu': false}, SetOptions(merge: true));
  }
}
