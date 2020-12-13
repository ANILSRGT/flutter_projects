import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:socialapp/services/s_storageservice.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File file;
  bool loading = false;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return file == null ? uploadButton() : postForm();
  }

  Widget uploadButton() {
    return IconButton(
      onPressed: () {
        changePhoto();
      },
      icon: Icon(
        Icons.file_upload,
        size: 50,
      ),
    );
  }

  Widget postForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Gönderi Oluştur",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              file = null;
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.black,
            ),
            onPressed: _createPost,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          loading ? LinearProgressIndicator() : SizedBox(height: 0),
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: "Açıklama Ekle",
              contentPadding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
            ),
          ),
          TextFormField(
            controller: locationController,
            decoration: InputDecoration(
              hintText: "Fotğraf Nerede Çekildi",
              contentPadding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _createPost() async {
    if (!loading) {
      setState(() {
        loading = true;
      });
      String photoUrl = await SStorageService().uploadPostPhoto(file);
      String activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;
      await SFireStoreService().createPost(
        postPhotoUrl: photoUrl,
        description: descriptionController.text,
        publishedId: activeUserId,
        location: locationController.text,
      );
      setState(() {
        loading = false;
        descriptionController.clear();
        locationController.clear();
        file = null;
      });
    }
  }

  changePhoto() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Gönderi Oluştur"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Fotoğraf çek"),
                onPressed: () {
                  takePhoto();
                },
              ),
              SimpleDialogOption(
                child: Text("Galeriden yükle"),
                onPressed: () {
                  uploadFromGallery();
                },
              ),
              SimpleDialogOption(
                child: Text("İptal"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  takePhoto() async {
    Navigator.pop(context);
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    setState(() {
      file = File(image.path);
    });
  }

  uploadFromGallery() async {
    Navigator.pop(context);
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    setState(() {
      file = File(image.path);
    });
  }
}
