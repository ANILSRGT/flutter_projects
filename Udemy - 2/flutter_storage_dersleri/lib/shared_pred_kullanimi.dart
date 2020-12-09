import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanimi extends StatefulWidget {
  @override
  _SharedPrefKullanimiState createState() => _SharedPrefKullanimiState();
}

class _SharedPrefKullanimiState extends State<SharedPrefKullanimi> {
  String isim;
  int id;
  bool cinsiyet;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SharedPreferences mySharedPreferences;

  @override
  void initState() async {
    super.initState();
    await SharedPreferences.getInstance().then((value) => mySharedPreferences = value);
  }

  @override
  void dispose() {
    formKey.currentState.dispose();
    (mySharedPreferences as State).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Pref Kullanımı"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (isim) {
                    this.isim = isim;
                  },
                  decoration: InputDecoration(
                    labelText: "İsminizi giriniz...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onSaved: (id) {
                    this.id = int.parse(id);
                  },
                  keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                  decoration: InputDecoration(
                    labelText: "ID giriniz...",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioListTile(
                  value: true,
                  groupValue: cinsiyet,
                  onChanged: (cinsiyet) {
                    setState(() {
                      this.cinsiyet = cinsiyet;
                    });
                  },
                  title: Text("Erkek"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RadioListTile(
                  value: false,
                  groupValue: cinsiyet,
                  onChanged: (cinsiyet) {
                    setState(() {
                      this.cinsiyet = cinsiyet;
                    });
                  },
                  title: Text("Kadın"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: _ekle,
                    child: Text("Kaydet"),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed: _goster,
                    child: Text("Göster"),
                    color: Colors.blue,
                  ),
                  RaisedButton(
                    onPressed: _sil,
                    child: Text("Sil"),
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _ekle() async {
    formKey.currentState.save();
    await mySharedPreferences.setString("myName", isim);
    await mySharedPreferences.setInt("myId", id);
    await mySharedPreferences.setBool("myCinsiyet", cinsiyet);
  }

  void _goster() {
    debugPrint("Okunan isim : " + mySharedPreferences.getString("myName") ?? "Null");
    debugPrint("Okunan id : " + mySharedPreferences.getInt("myId").toString() ?? "Null");
    debugPrint("Cinsiyet (E/K) -> (true/false) : " + mySharedPreferences.getBool("myCinsiyet").toString() ?? "Null");
  }

  void _sil() {
    mySharedPreferences.remove("myName");
    mySharedPreferences.remove("myId");
    mySharedPreferences.remove("myCinsiyet");
  }
}
