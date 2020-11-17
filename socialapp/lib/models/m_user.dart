import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MUsers {
  final String id;
  final String username;
  final String photoUrl;
  final String email;
  final String about;

  MUsers({this.id, this.username, this.photoUrl, this.email, this.about});

  factory MUsers.produceFromFirebase(User user) {
    return MUsers(
      id: user.uid,
      username: user.displayName,
      photoUrl: user.photoURL,
      email: user.email,
    );
  }

  factory MUsers.produceFromDocument(DocumentSnapshot doc) {
    return MUsers(
      id: doc.id,
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      email: doc['email'],
      about: doc['about'],
    );
  }
}
