import 'package:cloud_firestore/cloud_firestore.dart';

class MNotification {
  final String id;
  final String activityUserId;
  final String activityType;
  final String postId;
  final String postPhoto;
  final String comment;
  final Timestamp createdTime;

  MNotification(
      {this.id, this.activityUserId, this.activityType, this.postId, this.postPhoto, this.comment, this.createdTime});

  factory MNotification.produceFromDocument(DocumentSnapshot doc) {
    return MNotification(
      id: doc.id,
      activityUserId: doc.data()["activityUserId"],
      activityType: doc.data()["activityType"],
      postId: doc.data()["postId"],
      postPhoto: doc.data()["postPhoto"],
      comment: doc.data()["comment"],
      createdTime: doc.data()["createdTime"],
    );
  }
}
