import 'package:cloud_firestore/cloud_firestore.dart';

class MComment {
  final String id;
  final String content;
  final String publishedId;
  final Timestamp createdTime;

  MComment({this.id, this.content, this.publishedId, this.createdTime});

  factory MComment.produceFromDocument(DocumentSnapshot doc) {
    return MComment(
      id: doc.id,
      content: doc.data()['content'],
      publishedId: doc.data()['publishedId'],
      createdTime: doc.data()['createdTime'],
    );
  }
}
