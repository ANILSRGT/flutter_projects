import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnaSayfa extends StatelessWidget {
  cikisYap(BuildContext context) {
    Provider.of<BenimAuthServisim>(context, listen: false).cikisYap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => cikisYap(context),
          child: Text("Çıkış Yap"),
        ),
      ),
    );
  }
}
