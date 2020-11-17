import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/routing.dart';
import 'package:socialapp/services/s_authorizationservice.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SAuthorizationService>(
      create: (_) => SAuthorizationService(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        showSemanticsDebugger: false,
        debugShowCheckedModeBanner: false,
        title: 'Social App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Routing(),
      ),
    );
  }
}
