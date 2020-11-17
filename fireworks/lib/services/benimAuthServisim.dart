import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireworks/models/kullanici.dart';

class BenimAuthServisim {
  final _fireAuth = FirebaseAuth.instance;

  Kullanici _kullaniciOlustur(User fireUser) {
    return fireUser == null ? null : Kullanici.firebasedenUret(fireUser);
  }

  Stream<Kullanici> get durumTakipcisi {
    return _fireAuth.authStateChanges().map(_kullaniciOlustur);
  }

  Future<Kullanici> anonimGiris() async {
    var authResult = await _fireAuth.signInAnonymously();
    return _kullaniciOlustur(authResult.user);
  }

  Future<void> cikisYap() {
    return _fireAuth.signOut();
  }
}
