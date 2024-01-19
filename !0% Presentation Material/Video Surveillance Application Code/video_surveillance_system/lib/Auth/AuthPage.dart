import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';
import 'package:video_surveillance_system/Screens/SignUpScreen.dart';

class Auth_Page extends StatefulWidget {
  Auth_Page({super.key});

  @override
  State<Auth_Page> createState() => _Auth_PageState();
}

class _Auth_PageState extends State<Auth_Page> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return LoginScreen();
    } else {
      return SignUpScreen();
    }
  }
}
