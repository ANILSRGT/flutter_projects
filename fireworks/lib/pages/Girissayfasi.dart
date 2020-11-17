import 'package:fireworks/models/kullanici.dart';
import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GirisSayfasi extends StatelessWidget {
  anonimGirisYap(BuildContext context) async {
    BenimAuthServisim _benimAuthServisim = Provider.of<BenimAuthServisim>(context, listen: false);
    Kullanici kullanici = await _benimAuthServisim.anonimGiris();
    //return kullanici.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 80,
          width: 120,
          color: Colors.grey,
          child: Center(
            child: InkWell(
              onTap: () => anonimGirisYap(context),
              child: Text("Giriş Yap"),
            ),
          ),
        ),
      ),
    );
  }
}
