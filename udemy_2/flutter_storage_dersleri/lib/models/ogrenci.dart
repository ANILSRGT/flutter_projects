class Ogrenci {
  int id;
  String isim;
  int aktif;

  Ogrenci(this.isim, this.aktif);
  Ogrenci.withID(this.id, this.isim, this.aktif);
  Ogrenci.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.isim = map['isim'];
    this.aktif = map['aktif'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['isim'] = isim;
    map['aktif'] = aktif;
    return map;
  }

  @override
  String toString() {
    return 'Ogrenci{id: $id, isim: $isim, aktif: $aktif}';
  }
}
