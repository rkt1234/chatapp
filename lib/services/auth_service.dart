import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  User? _user;
  User? get user {
    return _user;
  }
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthService() {
    firebaseAuth.authStateChanges().listen(authStateChangesStreamListener);
  }

  Future<bool> login(String email, String password) async {
    try {
      final UserCredential credential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        _user=credential.user;
        return true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  void authStateChangesStreamListener(User? user) {
    if(user!=null) {
      _user=user;
    }
    else {
      _user=null;
    }

  }

  Future<bool> logout() async {
    try {
      await firebaseAuth.signOut();
      return true;

    } catch(e) {
      print(e);
    }
    return false;
  }
}
