import 'package:flutter/material.dart';
import 'package:fmarket/pages/urun_detay.dart';

class Kategori extends StatefulWidget {
  final String kategori;

  const Kategori({Key key, this.kategori}) : super(key: key);

  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  List<Widget> gosterilecekListe;

  @override
  void initState() {
    super.initState();

    if (widget.kategori == "Temel Gıda") {
      gosterilecekListe = <Widget>[
        urunKarti(
          "Zeytin Yağı",
          "₺23.50",
          "https://cdn.pixabay.com/photo/2016/05/24/13/29/olive-oil-1412361_960_720.jpg",
          mevcut: true,
        ),
        urunKarti(
          "Süt",
          "₺3.50",
          "https://cdn.pixabay.com/photo/2017/09/22/21/35/milk-2777165_960_720.jpg",
        ),
        urunKarti(
          "Peynir",
          "₺12.50",
          "https://cdn.pixabay.com/photo/2018/06/08/23/30/cheese-3463368_960_720.jpg",
        ),
        urunKarti(
          "Sosis",
          "₺7.50",
          "https://cdn.pixabay.com/photo/2019/05/31/21/40/sausage-4243068_960_720.jpg",
          mevcut: true,
        ),
      ];
    } else if (widget.kategori == "Şekerleme") {
      gosterilecekListe = <Widget>[
        urunKarti(
          "Ayıcık",
          "₺2.50",
          "https://cdn.pixabay.com/photo/2014/04/07/05/21/candies-318359__340.jpg",
        ),
        urunKarti(
          "Macaron",
          "₺2.50",
          "https://cdn.pixabay.com/photo/2016/11/18/17/20/colorful-1835921__340.jpg",
        ),
      ];
    } else if (widget.kategori == "İçecekler") {
      gosterilecekListe = <Widget>[
        urunKarti(
          "Coca Cola",
          "₺3.50",
          "https://cdn.pixabay.com/photo/2015/01/08/04/18/box-592367_960_720.jpg",
        ),
        urunKarti(
          "Portakal Suyu",
          "₺4.50",
          "https://cdn.pixabay.com/photo/2012/11/28/09/31/orange-juice-67556__340.jpg",
        ),
        urunKarti(
          "Elma Suyu",
          "₺5.50",
          "https://cdn.pixabay.com/photo/2016/08/10/20/09/juice-1584170__340.jpg",
        ),
        urunKarti(
          "Pepsi",
          "₺3.50",
          "https://cdn.pixabay.com/photo/2020/05/10/05/14/pepsi-5152332__340.jpg",
        ),
      ];
    } else if (widget.kategori == "Temizlik") {
      gosterilecekListe = <Widget>[
        urunKarti(
          "Mop",
          "₺25.50",
          "https://cdn.pixabay.com/photo/2017/09/10/18/10/mop-2736400__340.jpg",
        ),
        urunKarti(
          "Fiber Bez",
          "₺30.50",
          "https://cdn.pixabay.com/photo/2017/09/05/00/53/micro-fiber-cloth-2716115__340.jpg",
        ),
        urunKarti(
          "Sünger",
          "₺1.50",
          "https://cdn.pixabay.com/photo/2018/01/14/08/57/sponge-3081410_960_720.jpg",
        ),
      ];
    }
  }

  Widget urunKarti(String isim, String fiyat, String resimYolu, {bool mevcut = false}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UrunDetay(
            isim: isim,
            fiyat: fiyat,
            resimYolu: resimYolu,
            mevcut: mevcut,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: resimYolu,
              child: Container(
                width: 120,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(resimYolu),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              isim,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              fiyat,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: EdgeInsets.all(10),
      childAspectRatio: 1,
      children: gosterilecekListe,
    );
  }
}
