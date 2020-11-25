import 'package:burc_rehberi/burc_detay.dart';
import 'package:burc_rehberi/burc_liste.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Burç Rehberi",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: "burcListesi",
      routes: {
        "/": (context) => BurcListesi(),
        "burcListesi": (context) => BurcListesi(), // no pop
        "/burcListesi": (context) => BurcListesi(), // with pop
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElements = settings.name.split("/");

        if (pathElements[1] == "burcDetay") {
          return MaterialPageRoute(
            builder: (context) => BurcDetay(int.parse(pathElements[2])),
          );
        }
        return null;
      },
    );
  }
}
