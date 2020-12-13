import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dersAdi;
  int dersKredi = 1;
  double dersHarfDegeri = 4;
  List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;

  @override
  void initState() {
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Ortalama Hesapla"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait)
          return uygulamaGovdesi();
        else
          return uygulamaGovdesiLandscape();
      }),
    );
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //Static Formu Tutan Container
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ders Adı",
                      labelStyle: TextStyle(fontSize: 22),
                      hintText: "Ders adını giriniz",
                      hintStyle: TextStyle(fontSize: 18),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (inputValue) {
                      if (inputValue.length > 0) {
                        return null;
                      } else
                        return "Ders adı boş olamaz";
                    },
                    onSaved: (saveValue) {
                      dersAdi = saveValue;
                      setState(() {
                        tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi, createRandomColor()));
                        ortalama = 0;
                        ortalamayiHesapla();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            items: dersKrediItems(),
                            value: dersKredi,
                            onChanged: (secilenKredi) {
                              setState(() {
                                dersKredi = secilenKredi;
                              });
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<double>(
                            items: dersHarfDegerleriItems(),
                            value: dersHarfDegeri,
                            onChanged: (secilenHarf) {
                              setState(() {
                                dersHarfDegeri = secilenHarf < 0 ? 0 : secilenHarf;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //Not Ortalamasını Tutan Container
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.blue,
              border: BorderDirectional(
                top: BorderSide(color: Colors.blue, width: 2),
                bottom: BorderSide(color: Colors.blue, width: 2),
              ),
            ),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: tumDersler.length == 0 ? "Lütfen Ders Ekleyin" : "Ortalama : ",
                        style: TextStyle(fontSize: 30, color: Colors.white)),
                    TextSpan(
                        text: tumDersler.length == 0 ? "" : "${ortalama.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 40, color: Colors.purple, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          //Dinamik Liste Tutan Container
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: tumDersler.length,
                itemBuilder: _listeElemanlariniOlustur,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: "Ders Adı",
                            labelStyle: TextStyle(fontSize: 22),
                            hintText: "Ders adını giriniz",
                            hintStyle: TextStyle(fontSize: 18),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 2,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.purple,
                                width: 2,
                              ),
                            ),
                          ),
                          validator: (inputValue) {
                            if (inputValue.length > 0) {
                              return null;
                            } else
                              return "Ders adı boş olamaz";
                          },
                          onSaved: (saveValue) {
                            dersAdi = saveValue;
                            setState(() {
                              tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi, createRandomColor()));
                              ortalama = 0;
                              ortalamayiHesapla();
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: dersKrediItems(),
                                  value: dersKredi,
                                  onChanged: (secilenKredi) {
                                    setState(() {
                                      dersKredi = secilenKredi;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.purple,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: dersHarfDegerleriItems(),
                                  value: dersHarfDegeri,
                                  onChanged: (secilenHarf) {
                                    setState(() {
                                      dersHarfDegeri = secilenHarf < 0 ? 0 : secilenHarf;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: BorderDirectional(
                        top: BorderSide(color: Colors.blue, width: 2),
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: tumDersler.length == 0 ? "Lütfen Ders Ekleyin" : "Ortalama : ",
                                style: TextStyle(fontSize: 30, color: Colors.white)),
                            TextSpan(
                                text: tumDersler.length == 0 ? "" : "${ortalama.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 40, color: Colors.purple, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: ListView.builder(
                itemCount: tumDersler.length,
                itemBuilder: _listeElemanlariniOlustur,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      krediler.add(
        DropdownMenuItem<int>(
          value: i,
          child: Text(
            "$i Kredi",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      );
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(child: Text(" AA ", style: TextStyle(fontSize: 20)), value: 4));
    harfler.add(DropdownMenuItem(child: Text(" BA ", style: TextStyle(fontSize: 20)), value: 3.5));
    harfler.add(DropdownMenuItem(child: Text(" BB ", style: TextStyle(fontSize: 20)), value: 3));
    harfler.add(DropdownMenuItem(child: Text(" CB ", style: TextStyle(fontSize: 20)), value: 2.5));
    harfler.add(DropdownMenuItem(child: Text(" CC ", style: TextStyle(fontSize: 20)), value: 2));
    harfler.add(DropdownMenuItem(child: Text(" DC ", style: TextStyle(fontSize: 20)), value: 1.5));
    harfler.add(DropdownMenuItem(child: Text(" DD ", style: TextStyle(fontSize: 20)), value: 1));
    harfler.add(DropdownMenuItem(child: Text(" FD ", style: TextStyle(fontSize: 20)), value: 0.5));
    harfler.add(DropdownMenuItem(child: Text(" FF ", style: TextStyle(fontSize: 20)), value: 0));
    harfler.add(DropdownMenuItem(child: Text(" F0 ", style: TextStyle(fontSize: 20)), value: -1));

    return harfler;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;

    return Dismissible(
      key: Key("$sayac"),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamayiHesapla();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: tumDersler[index].renk, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        child: ListTile(
          leading: Icon(
            Icons.done_outline,
            size: 36,
            color: tumDersler[index].renk,
          ),
          title: Text(tumDersler[index].ad),
          subtitle: Text(tumDersler[index].kredi.toString() +
              " kredi\nKredi Ders Not Değer: " +
              tumDersler[index].harfDegeri.toString()),
          trailing: Icon(
            Icons.arrow_right,
            color: tumDersler[index].renk,
          ),
        ),
      ),
    );
  }

  void ortalamayiHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var onakiDers in tumDersler) {
      var kredi = onakiDers.kredi;
      var harfDegeri = onakiDers.harfDegeri;
      toplamNot += harfDegeri * kredi;
      toplamKredi += kredi;
    }
    ortalama = toplamNot / toplamKredi;
  }

  Color createRandomColor() {
    return Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));
  }
}

class Ders {
  String ad;
  double harfDegeri;
  int kredi;
  Color renk;

  Ders(this.ad, this.harfDegeri, this.kredi, this.renk);
}
