import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/landing_page.dart';
import 'package:flutter_lovers/viewmodels/user_model.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Lovers',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserModel(),
        child: LandingPage(),
      ),
    );
  }
}
