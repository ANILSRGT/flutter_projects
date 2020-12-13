import 'package:flutter/material.dart';
import 'package:flutter_storage_dersleri/utils/database_helper.dart';
import 'package:flutter_storage_dersleri/models/ogrenci.dart';

class SqfLiteIslemleri extends StatefulWidget {
  @override
  _SqfLiteIslemleriState createState() => _SqfLiteIslemleriState();
}

class _SqfLiteIslemleriState extends State<SqfLiteIslemleri> {
  DatabaseHelper _databaseHelper;
  List<Ogrenci> tumOgrencilerListesi;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool aktiflik = false;
  TextEditingController _controller = TextEditingController();
  int tiklanilanOgrenciIndexi;
  int tiklanilanOgrenciIDsi;

  @override
  void initState() {
    super.initState();
    tumOgrencilerListesi = List<Ogrenci>();
    _databaseHelper = DatabaseHelper();
    _databaseHelper.tumOgrenciler().then((List<Map<String, dynamic>> value) {
      value.map((e) {
        tumOgrencilerListesi.add(Ogrenci.fromMap(e));
      });
    }).catchError((error) => print("Hata : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SqfLite Kullanımı"),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controller,
                      autofocus: false,
                      validator: (value) {
                        if (value.length < 3) {
                          return "En az 3 karakter olmalı!";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: "Ögrenci ismini giriniz...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: Text("Aktif"),
                    value: aktiflik,
                    onChanged: (isActive) {
                      setState(() {
                        aktiflik = isActive;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  child: Text("Kaydet"),
                  color: Colors.green,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _ogrenciEkle(Ogrenci(_controller.text, aktiflik ? 1 : 0));
                    }
                  },
                ),
                RaisedButton(
                  child: Text("Güncelle"),
                  color: Colors.yellow,
                  onPressed: (tiklanilanOgrenciIDsi == null || tiklanilanOgrenciIndexi == null)
                      ? null
                      : () {
                          if (_formKey.currentState.validate()) {
                            _ogrenciGuncelle(Ogrenci.withID(tiklanilanOgrenciIDsi, _controller.text, aktiflik ? 1 : 0));
                          }
                        },
                ),
                RaisedButton(
                  child: Text("Tüm Tabloyu Sil"),
                  color: Colors.red,
                  onPressed: () {
                    _tumTabloyuSil();
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tumOgrencilerListesi.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: tumOgrencilerListesi[index].aktif == 1 ? Colors.green.shade200 : Colors.red.shade200,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          tiklanilanOgrenciIndexi = index;
                          _controller.text = tumOgrencilerListesi[index].isim;
                          aktiflik = tumOgrencilerListesi[index].aktif == 1 ? true : false;
                          tiklanilanOgrenciIDsi = tumOgrencilerListesi[index].id;
                        });
                      },
                      title: Text(tumOgrencilerListesi[index].isim),
                      subtitle: Text(tumOgrencilerListesi[index].id.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _ogrenciSil(tumOgrencilerListesi[index].id, index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ogrenciEkle(Ogrenci ogrenci) async {
    int eklenenOgrencininIDsi = await _databaseHelper.ogrenciEkle(ogrenci);
    ogrenci.id = eklenenOgrencininIDsi;
    if (eklenenOgrencininIDsi > 0) {
      setState(() {
        tumOgrencilerListesi.insert(0, ogrenci);
      });
    }
  }

  void _tumTabloyuSil() async {
    var silinenElemanSayisi = await _databaseHelper.tumOgrenciTablosunuSil();
    if (silinenElemanSayisi > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text(silinenElemanSayisi.toString() + " kayıt silindi!"),
      ));
      setState(() {
        tumOgrencilerListesi.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Kayıtlar silinemedi!"),
      ));
    }
    tiklanilanOgrenciIDsi = null;
    tiklanilanOgrenciIndexi = null;
  }

  void _ogrenciSil(int dbId, int listeIndex) async {
    int sonuc = await _databaseHelper.ogrenciSil(dbId);
    if (sonuc == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Öğrenci silindi!"),
      ));
      setState(() {
        tumOgrencilerListesi.removeAt(listeIndex);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Hata çıktı!"),
      ));
    }
    tiklanilanOgrenciIDsi = null;
    tiklanilanOgrenciIndexi = null;
  }

  void _ogrenciGuncelle(Ogrenci ogrenci) async {
    int sonuc = await _databaseHelper.ogrenciGuncelle(ogrenci);
    if (sonuc == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Öğrenci kaydı güncellendi!"),
      ));
      setState(() {
        tumOgrencilerListesi[tiklanilanOgrenciIndexi] = ogrenci;
      });
    }
  }
}
