import 'package:flutter/material.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/models/muser.dart';
import 'package:flutter_lovers/repository/user_repository.dart';
import 'package:flutter_lovers/services/auth_base.dart';

enum ViewState { IDLE, BUSY }

class UserModel with ChangeNotifier implements AuthBase {
  ViewState _state = ViewState.IDLE;
  UserRepository _userRepository = locator<UserRepository>();
  MUser _user;

  MUser get user => _user;

  ViewState get state => _state;

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  UserModel() {
    currentUser();
  }

  @override
  MUser currentUser() {
    try {
      state = ViewState.BUSY;
      _user = _userRepository.currentUser();
      return _user;
    } catch (e) {
      print("Viewmodeldeki Current user hata: $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.BUSY;
      bool sonuc = await _userRepository.signOut();
      _user = null;
      return sonuc;
    } catch (e) {
      print("Viewmodeldeki Current user hata: $e");
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<MUser> signInAnonymously() async {
    try {
      state = ViewState.BUSY;
      _user = await _userRepository.signInAnonymously();
      return _user;
    } catch (e) {
      print("Viewmodeldeki Current user hata: $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<MUser> signInWithGoogle() async {
    try {
      state = ViewState.BUSY;
      _user = await _userRepository.signInWithGoogle();
      return _user;
    } catch (e) {
      print("Viewmodeldeki Current user hata: $e");
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  Future<MUser> signInWithFacebook() {
    // TODO: implement signInWithFacebook
    throw UnimplementedError();
  }
}
