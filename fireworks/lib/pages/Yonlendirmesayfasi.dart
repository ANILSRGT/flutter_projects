import 'package:fireworks/models/kullanici.dart';
import 'package:fireworks/pages/Anasayfa.dart';
import 'package:fireworks/pages/Girissayfasi.dart';
import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class YonlendirmeSayfasi extends StatefulWidget {
  @override
  _YonlendirmeSayfasiState createState() => _YonlendirmeSayfasiState();
}

class _YonlendirmeSayfasiState extends State<YonlendirmeSayfasi> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<BenimAuthServisim>(context, listen: false).durumTakipcisi,
      builder: (BuildContext context, AsyncSnapshot<Kullanici> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          Kullanici aktifKullanici = snapshot.data;
          print(aktifKullanici.id);
          return AnaSayfa();
        } else {
          return GirisSayfasi();
        }
      },
    );
  }
}
