import 'package:fireworks/pages/Yonlendirmesayfasi.dart';
import 'package:fireworks/services/benimAuthServisim.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<BenimAuthServisim>(
      create: (_) => BenimAuthServisim(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Projem',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: YonlendirmeSayfasi(),
      ),
    );
  }
}
