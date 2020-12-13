import 'package:flutter/material.dart';
//import 'package:flutter_storage_dersleri/dosya_islemleri.dart';
import 'package:flutter_storage_dersleri/sqflite_islemleri.dart';
//import 'package:flutter_storage_dersleri/shared_pred_kullanimi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Storage Dersleri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SqfLiteIslemleri(),
    );
  }
}
