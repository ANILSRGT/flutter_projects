import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

class DosyaIslemleri extends StatefulWidget {
  @override
  _DosyaIslemleriState createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  TextEditingController txtEditingCtrl = TextEditingController();

  Future<String> get getKlasorYolu async {
    Directory klasor = await getApplicationDocumentsDirectory();
    return klasor.path;
  }

  Future<File> get dosyaOlustur async {
    String klasorYolu = await getKlasorYolu;
    return File(klasorYolu + "/myDosya.txt");
  }

  Future<String> dosyaOku() async {
    try {
      File myDosya = await dosyaOlustur;
      String dosyaIcerigi = await myDosya.readAsString();
      return dosyaIcerigi;
    } catch (e) {
      return "Hata : $e";
    }
  }

  Future<File> dosyayaYaz(String yazilacakString) async {
    File myDosya = await dosyaOlustur;
    return myDosya.writeAsString(yazilacakString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dosya İşlemleri"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtEditingCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Dosyaya kaydedilecek metin...",
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: _dosyayaYaz,
                  color: Colors.green,
                  child: Text("Dosyaya Yaz"),
                ),
                RaisedButton(
                  onPressed: _dosyadanOku,
                  color: Colors.green,
                  child: Text("Dosyadan Oku"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _dosyayaYaz() {
    dosyayaYaz(txtEditingCtrl.text.toString());
  }

  void _dosyadanOku() {
    dosyaOku().then((icerik) => print(icerik));
  }
}
