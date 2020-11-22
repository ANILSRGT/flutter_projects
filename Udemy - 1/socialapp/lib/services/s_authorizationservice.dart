import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialapp/models/m_user.dart';

class SAuthorizationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String activeUserId;

  MUsers _createUser(User user) {
    return user == null ? null : MUsers.produceFromFirebase(user);
  }

  Stream<MUsers> get statusTracker {
    return _firebaseAuth.authStateChanges().map(_createUser);
  }

  Future<MUsers> registerWithEmail(String email, String password) async {
    var loginCart = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _createUser(loginCart.user);
  }

  Future<MUsers> singInWithEmail(String email, String password) async {
    var loginCart = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _createUser(loginCart.user);
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<MUsers> loginWithGoogle() async {
    GoogleSignInAccount googleAccount = await GoogleSignIn().signIn();
    GoogleSignInAuthentication googleAuthCart = await googleAccount.authentication;
    OAuthCredential passwordlessLoginDocument =
        GoogleAuthProvider.credential(idToken: googleAuthCart.idToken, accessToken: googleAuthCart.accessToken);
    UserCredential loginCart = await _firebaseAuth.signInWithCredential(passwordlessLoginDocument);
    return _createUser(loginCart.user);
  }
}
