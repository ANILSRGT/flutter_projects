import 'package:flutter_lovers/models/muser.dart';

abstract class AuthBase {
  MUser currentUser();
  Future<MUser> signInAnonymously();
  Future<bool> signOut();
  Future<MUser> signInWithGoogle();
  Future<MUser> signInWithFacebook();
}
