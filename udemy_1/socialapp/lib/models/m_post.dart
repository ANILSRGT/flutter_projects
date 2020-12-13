import 'package:cloud_firestore/cloud_firestore.dart';

class MPost {
  final String id;
  final String photoUrl;
  final String description;
  final String publishedId;
  final int likeCount;
  final String location;

  MPost({this.id, this.photoUrl, this.description, this.publishedId, this.likeCount, this.location});

  factory MPost.produceFromDocument(DocumentSnapshot doc) {
    return MPost(
      id: doc.id,
      photoUrl: doc.data()['postPhotoUrl'],
      description: doc.data()['description'],
      publishedId: doc.data()['publishedId'],
      likeCount: doc.data()['likeCount'],
      location: doc.data()['location'],
    );
  }
}
