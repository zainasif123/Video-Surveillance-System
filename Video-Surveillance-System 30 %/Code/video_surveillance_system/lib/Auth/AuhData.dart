import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Data/Firestore.dart';

abstract class AuthenticationDatasource {
  //Future<void> register(String email, String password, String PasswordConfirm);
  Future<void> registerusers(String email, String password);
  Future<void> login(String email, String password, BuildContext context);
}

class AuthenticationRemote extends AuthenticationDatasource {
  @override
  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("USer not found:"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 600.0),
        ),
      );
    }
  }

  // @override
  // Future<void> register(
  //     String email, String password, String PasswordConfirm) async {
  //   if (PasswordConfirm == password) {
  //     await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(
  //             email: email.trim(), password: password.trim())
  //         .then((value) {
  //       Firestore_Datasource().CreateAdmin(email, password);
  //     });
  //   }
  // }

  @override
  Future<void> registerusers(String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) {
      Firestore_Datasource().CreateUser(email, password);
    });
  }
}
