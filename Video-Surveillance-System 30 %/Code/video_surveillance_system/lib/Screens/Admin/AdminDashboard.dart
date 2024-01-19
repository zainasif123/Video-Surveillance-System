import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/Admin/AddUsers.dart';
import 'package:video_surveillance_system/Screens/Users/DetectionClips.dart';
import 'package:video_surveillance_system/Screens/Users/UploadVideo.dart';
import 'package:video_surveillance_system/Utils/dd.dart';
import 'package:video_surveillance_system/Widgets/AdminDrawer.dart';

import 'DeleteUserScreen.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        automaticallyImplyLeading: true,
        title: Text('Admin Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.info),
            ),
          )
        ],
      ),
      drawer: Custom_Drawer(context),
      backgroundColor: Colors.white70,
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        children: <Widget>[
          AdminGridItem(
            title: 'Create User',
            icon: Icons.person_add,
            onTap: () {
              // Implement action for creating a user
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => AddUsers()));
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => AddUsers()));
            },
          ),
          AdminGridItem(
            title: 'Delete User',
            icon: Icons.delete,
            onTap: () {
              // Implement action for deleting a user
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DeleteUsers()));
            },
          ),
          AdminGridItem(
            title: 'Detection Frame',
            icon: Icons.play_arrow,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetectionClips(id: "Detected Frame History")));
              // Implement action for handling notifications
            },
          ),
          AdminGridItem(
            title: 'Upload Video',
            icon: Icons.video_library,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VideoPickerScreenDemo()));

              // Implement action for uploading a video
            },
          ),
          AdminGridItem(
            title: 'Notifications',
            icon: Icons.notifications,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NotificationDemoScreen()));
              // Implement action for handling notifications
            },
          ),
          AdminGridItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {
              showAboutDialog(
                context: context,
                applicationIcon: FlutterLogo(),
                applicationLegalese: 'A Violence Detection Application',
                applicationName: 'Video Surveillance App',
                applicationVersion: 'version 1.0.0',
                children: [
                  Text('Press licence button to view App Settings'),
                ],
              );
            },
          )
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
