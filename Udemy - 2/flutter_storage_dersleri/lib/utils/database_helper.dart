import 'dart:async';
import 'dart:io';
import 'package:flutter_storage_dersleri/models/ogrenci.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _ogrenciTablo = "t_ogrenci";
  String _columnID = "id";
  String _columnIsim = 'isim';
  String _columnAktif = 'aktif';

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initializeDatabase() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String dbPath = join(klasor.path, "ogrenci.db");
    print("DB Path : " + dbPath);

    var ogrDB = openDatabase(dbPath, version: 1, onCreate: _createDB);
    return ogrDB;
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_ogrenciTablo ($_columnID INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif INTEGER )");
  }

  Future<int> ogrenciEkle(Ogrenci ogr) async {
    Database db = await _getDatabase();
    int sonuc = await db.insert(_ogrenciTablo, ogr.toMap(), nullColumnHack: "$_columnID");
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumOgrenciler() async {
    Database db = await _getDatabase();
    List<Map<String, dynamic>> sonuc = await db.query(_ogrenciTablo, orderBy: "$_columnID DESC");
    return sonuc;
  }

  Future<int> ogrenciGuncelle(Ogrenci ogr) async {
    Database db = await _getDatabase();
    int sonuc = await db.update(_ogrenciTablo, ogr.toMap(), where: '$_columnID = ?', whereArgs: [ogr.id]);
    return sonuc;
  }

  Future<int> ogrenciSil(int ogrId) async {
    Database db = await _getDatabase();
    int sonuc = await db.delete(_ogrenciTablo, where: "$_columnID = ?", whereArgs: [ogrId]);
    return sonuc;
  }

  Future<int> tumOgrenciTablosunuSil() async {
    Database db = await _getDatabase();
    int sonuc = await db.delete(_ogrenciTablo);
    return sonuc;
  }
}
