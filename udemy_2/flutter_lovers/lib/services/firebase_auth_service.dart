import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lovers/models/muser.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  MUser currentUser() {
    try {
      User user = _firebaseAuth.currentUser;
      return _userFromFirebase(user);
    } catch (e) {
      print("HATA CURRENT USER : $e");
      return null;
    }
  }

  MUser _userFromFirebase(User user) {
    if (user == null) return null;
    return MUser(userID: user.uid);
  }

  @override
  Future<bool> signOut() async {
    try {
      final _googleSignIn = GoogleSignIn();
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("HATA SIGN OUT : $e");
      return false;
    }
  }

  @override
  Future<MUser> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return _userFromFirebase(userCredential.user);
    } catch (e) {
      print("HATA SIGN IN ANONYMOUSLY : $e");
      return null;
    }
  }

  @override
  Future<MUser> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();

    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        GoogleAuthCredential credential = GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        );
        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        return _userFromFirebase(userCredential.user);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
