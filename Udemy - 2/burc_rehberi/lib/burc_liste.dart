import 'package:burc_rehberi/models/burc.dart';
import 'package:burc_rehberi/utils/strings.dart';
import 'package:flutter/material.dart';

class BurcListesi extends StatelessWidget {
  static List<Burc> burcList;

  @override
  Widget build(BuildContext context) {
    burcList = getBurcList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Burç Rehberi"),
      ),
      body: crateList(burcList),
    );
  }

  List<Burc> getBurcList() {
    List<Burc> burclar = [];

    for (int i = 0; i < 12; i++) {
      String kucukResim = Strings.BURC_ADLARI[i].toLowerCase() + "${i + 1}.png";
      String buyukResim = Strings.BURC_ADLARI[i].toLowerCase() + "_buyuk".toLowerCase() + "${i + 1}.png";

      Burc eklenecekBurc = Burc(
          Strings.BURC_ADLARI[i], Strings.BURC_TARIHLERI[i], Strings.BURC_GENEL_OZELLIKLERI[i], kucukResim, buyukResim);
      burclar.add(eklenecekBurc);
    }

    return burclar;
  }

  Widget crateList(List<Burc> burcList) {
    return ListView.builder(
      itemCount: burcList.length,
      itemBuilder: (BuildContext context, int index) {
        return createSingleBurcElement(context, index);
      },
    );
  }

  Widget createSingleBurcElement(BuildContext context, int index) {
    Burc burcToAdd = burcList[index];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () => Navigator.pushNamed(context, "/burcDetay/$index"),
          leading: Image.asset(
            "images/" + burcToAdd.burcKucukResim,
            width: 64,
            height: 64,
          ),
          title: Text(
            burcToAdd.burcAdi,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
              color: Colors.pink.shade500,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              burcToAdd.burcTarihi,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black38,
              ),
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Colors.pink,
          ),
        ),
      ),
    );
  }
}
