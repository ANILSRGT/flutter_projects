import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class SStorageService {
  Reference _storage = FirebaseStorage.instance.ref().root;
  String photoId;

  Future<String> uploadPostPhoto(File photoFile) async {
    photoId = Uuid().v4();
    UploadTask uploadManager = _storage.child("images/posts/post_$photoId.jpg").putFile(photoFile);
    TaskSnapshot snapshot = await uploadManager.then((value) => value);
    String uploadedPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadedPhotoUrl;
  }

  Future<String> uploadProfilePhoto(File photoFile) async {
    photoId = Uuid().v4();
    UploadTask uploadManager = _storage.child("images/profile/profile_$photoId.jpg").putFile(photoFile);
    TaskSnapshot snapshot = await uploadManager.then((value) => value);
    String uploadedPhotoUrl = await snapshot.ref.getDownloadURL();
    return uploadedPhotoUrl;
  }

  void deletePostPhoto(String postPhotoUrl) {
    RegExp search = RegExp(r"post_.+\.jpg");
    var match = search.firstMatch(postPhotoUrl);
    String fileName = match[0];

    if (fileName.isNotEmpty) {
      _storage.child("images/posts/$fileName").delete();
    }
  }
}
