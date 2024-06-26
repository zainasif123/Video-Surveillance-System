import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';
import 'package:video_surveillance_system/Screens/Users/DetectionClips.dart';
import 'package:video_surveillance_system/Screens/Users/UploadVideo.dart';
import 'package:video_surveillance_system/Utils/dd.dart';
import 'package:video_surveillance_system/Widgets/AdminDrawer.dart';
import 'package:video_surveillance_system/Widgets/UserDrawer.dart';

class UserDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('User Dashboard'),
      ),
      backgroundColor: Colors.white70,
      drawer: Custom_Drawer_User(context),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: <Widget>[
          AdminGridItem(
            title: 'Detected Frame',
            icon: Icons.video_settings,
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => DetectionClips()));
              // Implement action for creating a user
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetectionClips(id: "Detected Frame History")));
            },
          ),
          AdminGridItem(
            title: 'Notification',
            icon: Icons.notifications,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NotificationDemoScreen()));
              // Implement action for handling notifications
            },
          ),
          AdminGridItem(
            title: 'Detect Violence',
            icon: Icons.video_library,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPickerScreenDemo()));
              // Implement action for uploading a video
            },
          ),
          // AdminGridItem(
          //   title: 'Settings',
          //   icon: Icons.settings,
          //   onTap: () {
          //     showAboutDialog(
          //       context: context,
          //       applicationIcon: FlutterLogo(),
          //       applicationLegalese: 'Legalese',
          //       applicationName: 'Flutter App',
          //       applicationVersion: 'version 1.0.0',
          //       children: [
          //         Text('This is a text created by Flutter Mapp'),
          //       ],
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class AdminGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  AdminGridItem({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 60,
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
