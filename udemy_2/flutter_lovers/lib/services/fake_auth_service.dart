import 'package:flutter_lovers/models/muser.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  final userID = "12401920123589104582093850293";
  @override
  MUser currentUser() {
    return MUser(userID: userID);
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<MUser> signInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2), () => MUser(userID: userID));
  }

  @override
  Future<MUser> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
