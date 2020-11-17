import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialapp/models/m_notification.dart';
import 'package:socialapp/models/m_post.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_storageservice.dart';

class SFireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final DateTime time = DateTime.now();

  Future<void> createUser({id, email, username, photoUrl = ""}) async {
    await _firestore.collection("users").doc(id).set({
      "username": username,
      "email": email,
      "photoUrl": photoUrl,
      "about": "",
      "creationTime": time,
    });
  }

  Future<MUsers> getUser(id) async {
    DocumentSnapshot doc = await _firestore.collection("users").doc(id).get();
    if (doc.exists) {
      MUsers user = MUsers.produceFromDocument(doc);
      return user;
    }
    return null;
  }

  void updateUser({String userId, String username, String photoUrl = "", String about}) {
    _firestore.collection("users").doc(userId).update({
      "username": username,
      "about": about,
      "photoUrl": photoUrl,
    });
  }

  Future<List<MUsers>> searchUser(String username) async {
    QuerySnapshot snapshot =
        await _firestore.collection("users").where("username", isGreaterThanOrEqualTo: username).get();

    List<MUsers> users = snapshot.docs.map((doc) => MUsers.produceFromDocument(doc)).toList();
    return users;
  }

  void follow({String activeUserId, String profileOwnerId}) {
    _firestore.collection("followers").doc(profileOwnerId).collection("followersOfUser").doc(activeUserId).set({});
    _firestore.collection("followeds").doc(activeUserId).collection("followedsOfUser").doc(profileOwnerId).set({});

    addNotification(
      activityType: "follow",
      activityUserId: activeUserId,
      profileOwnerId: profileOwnerId,
    );
  }

  void unfollow({String activeUserId, String profileOwnerId}) {
    _firestore
        .collection("followers")
        .doc(profileOwnerId)
        .collection("followersOfUser")
        .doc(activeUserId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    _firestore
        .collection("followeds")
        .doc(activeUserId)
        .collection("followedsOfUser")
        .doc(profileOwnerId)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  Future<bool> followCtrl({String activeUserId, String profileOwnerId}) async {
    DocumentSnapshot doc = await _firestore
        .collection("followers")
        .doc(profileOwnerId)
        .collection("followersOfUser")
        .doc(activeUserId)
        .get();

    if (doc.exists) {
      return true;
    }
    return false;
  }

  Future<int> followerCount(userId) async {
    QuerySnapshot snapshot = await _firestore.collection("followers").doc(userId).collection("followersOfUser").get();
    return snapshot.docs.length;
  }

  Future<int> followedCount(userId) async {
    QuerySnapshot snapshot = await _firestore.collection("followeds").doc(userId).collection("followedsOfUser").get();
    return snapshot.docs.length;
  }

  void addNotification(
      {String activityUserId, String profileOwnerId, String activityType, String comment, MPost post}) {
    if (activityUserId == profileOwnerId) {
      return;
    }
    _firestore.collection("notifications").doc(profileOwnerId).collection("notificationsOfUser").add({
      "activityUserId": activityUserId,
      "activityType": activityType,
      "postId": post?.id,
      "postPhoto": post?.photoUrl,
      "comment": comment,
      "createdTime": time,
    });
  }

  Future<List<MNotification>> getNotifications(String profileOwnerId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("notifications")
        .doc(profileOwnerId)
        .collection("notificationsOfUser")
        .orderBy("createdTime", descending: true)
        .limit(20)
        .get();

    List<MNotification> notifications = [];

    snapshot.docs.forEach((DocumentSnapshot doc) {
      MNotification notification = MNotification.produceFromDocument(doc);
      notifications.add(notification);
    });

    return notifications;
  }

  Future<void> createPost({postPhotoUrl, description, publishedId, location}) async {
    await _firestore.collection("posts").doc(publishedId).collection("postsOfUser").add({
      "postPhotoUrl": postPhotoUrl,
      "description": description,
      "likeCount": 0,
      "publishedId": publishedId,
      "location": location,
      "createdTime": time,
    });
  }

  Future<List<MPost>> getPosts(userId) async {
    var snapshot = await _firestore
        .collection("posts")
        .doc(userId)
        .collection("postsOfUser")
        .orderBy("createdTime", descending: true)
        .get();
    var posts = snapshot.docs.map((doc) => MPost.produceFromDocument(doc)).toList();
    return posts;
  }

  Future<List<MPost>> getStreamingPosts(userId) async {
    var snapshot = await _firestore
        .collection("streams")
        .doc(userId)
        .collection("streamingPostsOfUser")
        .orderBy("createdTime", descending: true)
        .get();
    var posts = snapshot.docs.map((doc) => MPost.produceFromDocument(doc)).toList();
    return posts;
  }

  Future<void> deletePost({String activeUserId, MPost post}) async {
    _firestore
        .collection("posts")
        .doc(activeUserId)
        .collection("postsOfUser")
        .doc(post.id)
        .get()
        .then((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    QuerySnapshot commentsSnapshot =
        await _firestore.collection("comments").doc(post.id).collection("postComments").get();
    commentsSnapshot.docs.forEach((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    QuerySnapshot notificationsSnapshot = await _firestore
        .collection("notifications")
        .doc(post.publishedId)
        .collection("notificationsOfUser")
        .where("postId", isEqualTo: post.id)
        .get();

    notificationsSnapshot.docs.forEach((DocumentSnapshot doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });

    SStorageService().deletePostPhoto(post.photoUrl);
  }

  Future<MPost> getSinglePost(String postId, String postOwnerId) async {
    DocumentSnapshot doc =
        await _firestore.collection("posts").doc(postOwnerId).collection("postsOfUser").doc(postId).get();
    MPost post = MPost.produceFromDocument(doc);
    return post;
  }

  Future<void> likePost(MPost post, String activeUserId) async {
    DocumentReference docRef =
        _firestore.collection("posts").doc(post.publishedId).collection("postsOfUser").doc(post.id);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      MPost post = MPost.produceFromDocument(doc);
      int newLikeCount = post.likeCount + 1;
      docRef.update({
        "likeCount": newLikeCount,
      });

      _firestore.collection("likes").doc(post.id).collection("likesOfPost").doc(activeUserId).set({});
    }

    addNotification(
      activityType: "like",
      activityUserId: activeUserId,
      post: post,
      profileOwnerId: post.publishedId,
    );
  }

  Future<void> removeLikePost(MPost post, String activeUserId) async {
    DocumentReference docRef =
        _firestore.collection("posts").doc(post.publishedId).collection("postsOfUser").doc(post.id);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      MPost post = MPost.produceFromDocument(doc);
      int newLikeCount = post.likeCount - 1;
      docRef.update({
        "likeCount": newLikeCount,
      });
    }

    DocumentSnapshot docLike =
        await _firestore.collection("likes").doc(post.id).collection("likesOfPost").doc(activeUserId).get();
    if (docLike.exists) {
      docLike.reference.delete();
    }
  }

  Future<bool> isLike(MPost post, String activeUserId) async {
    DocumentSnapshot docLike =
        await _firestore.collection("likes").doc(post.id).collection("likesOfPost").doc(activeUserId).get();

    if (docLike.exists) {
      return true;
    }

    return false;
  }

  Stream<QuerySnapshot> getComments(String postId) {
    return _firestore
        .collection("comments")
        .doc(postId)
        .collection("postComments")
        .orderBy("createdTime", descending: true)
        .snapshots();
  }

  void addComment({String activeUserId, MPost post, String content}) {
    _firestore.collection("comments").doc(post.id).collection("postComments").add({
      "content": content,
      "publishedId": activeUserId,
      "createdTime": time,
    });

    addNotification(
      activityType: "comment",
      activityUserId: activeUserId,
      post: post,
      profileOwnerId: post.publishedId,
      comment: content,
    );
  }
}
