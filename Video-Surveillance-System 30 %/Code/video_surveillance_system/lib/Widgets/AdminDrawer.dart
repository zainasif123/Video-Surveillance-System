import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';
import 'package:video_surveillance_system/Widgets/AdminUpdateCredentialScreen.dart';

Widget Custom_Drawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.white70,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 100,
                  height: 100,
                  child: Image.asset("images/profile.png")),
              Text(
                'Profile Drawer',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.account_circle,
            color: Colors.blue,
          ),
          title: Text('Update Profile'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    UpdateEmailPasswordScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            color: Colors.blue,
          ),
          title: Text('Settings'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationIcon: FlutterLogo(),
              applicationLegalese: 'Legalese',
              applicationName: 'Flutter App',
              applicationVersion: 'version 1.0.0',
              children: [
                Text('This is a text created by Flutter Mapp'),
              ],
            );
          },
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.blue,
          ),
          title: Text('Log out'),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => LoginScreen()));
          },
        ),
      ],
    ),
  );
}
