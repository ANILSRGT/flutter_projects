import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:socialapp/models/m_user.dart';
import 'package:socialapp/services/s_authorizationservice.dart';
import 'package:socialapp/services/s_firestoreservice.dart';
import 'package:socialapp/services/s_storageservice.dart';

class EditProfilePage extends StatefulWidget {
  final MUsers profile;

  const EditProfilePage({Key key, this.profile}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var _formKey = GlobalKey<FormState>();
  String _username;
  String _about;
  File _selectedPhoto;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Profili Düzenle",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.black,
            ),
            onPressed: _save,
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _loading ? LinearProgressIndicator() : SizedBox(height: 0),
          _profilePhoto(),
          SizedBox(
            height: 20,
          ),
          _userInformations(),
        ],
      ),
    );
  }

  _save() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      _formKey.currentState.save();

      String profilePhotoUrl;
      if (_selectedPhoto == null) {
        profilePhotoUrl = widget.profile.photoUrl;
      } else {
        profilePhotoUrl = await SStorageService().uploadProfilePhoto(_selectedPhoto);
      }

      String activeUserId = Provider.of<SAuthorizationService>(context, listen: false).activeUserId;

      SFireStoreService().updateUser(
        userId: activeUserId,
        username: _username,
        about: _about,
        photoUrl: profilePhotoUrl,
      );

      setState(() {
        _loading = false;
      });

      Navigator.pop(context);
    }
  }

  _profilePhoto() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 20,
      ),
      child: Center(
        child: InkWell(
          onTap: _uploadFromGallery,
          child: CircleAvatar(
            backgroundImage: _selectedPhoto == null ? NetworkImage(widget.profile.photoUrl) : FileImage(_selectedPhoto),
            backgroundColor: Colors.grey,
            radius: 55,
          ),
        ),
      ),
    );
  }

  _uploadFromGallery() async {
    PickedFile image = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
      imageQuality: 80,
    );
    setState(() {
      _selectedPhoto = File(image.path);
    });
  }

  _userInformations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: widget.profile.username,
              decoration: InputDecoration(
                labelText: "username",
              ),
              validator: (inputValue) {
                if (inputValue.isEmpty) {
                  return "Kullanıcı adı alanı boş bırakılamaz!";
                } else if (inputValue.trim().length < 6 || inputValue.trim().length > 12) {
                  return "Girilen değer 6-12 karakter uzunluğunda olmalı!";
                } else {
                  return null;
                }
              },
              onSaved: (inputValue) {
                _username = inputValue;
              },
            ),
            TextFormField(
              initialValue: widget.profile.about,
              decoration: InputDecoration(
                labelText: "Hakkında",
              ),
              validator: (inputValue) {
                return inputValue.trim().length > 100 ? "Girilen değer 100 karakterden uzun olamaz!" : null;
              },
              onSaved: (inputValue) {
                _about = inputValue;
              },
            ),
          ],
        ),
      ),
    );
  }
}
