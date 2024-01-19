import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Auth/AuthPage.dart';
import 'package:video_surveillance_system/Screens/Admin/AddUsers.dart';
import 'package:video_surveillance_system/Screens/Admin/AdminDashboard.dart';
import 'package:video_surveillance_system/Screens/Users/UserDashboard.dart';
import 'package:video_surveillance_system/const/adminUID.dart';

class Main_Page extends StatelessWidget {
  const Main_Page({super.key});
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // if (snapshot.hasData) {

        //   debugPrint(
        //       '${snapshot.hasData.toString()}zainaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
        //   return Auth_Page();
        // } else {
        //   return Auth_Page();
        // }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // You can display a loading indicator while checking the user's role.
        }
        if (snapshot.hasData) {
          final User? user = snapshot.data;
          final userEmail = user!.email;
          if (userEmail != null) {
            // Check the user's role in Firestore based on their email
            return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('admin')
                    .doc(adminuid)
                    .get(),
                builder: (context, docSnapshot) {
                  if (docSnapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Loading indicator while fetching user role.
                  }
                  if (docSnapshot.hasData) {
                    String userRole = docSnapshot.data!['email'];
                    if (userRole ==
                        FirebaseAuth.instance.currentUser?.email.toString()) {
                      // Navigate to the admin dashboard
                      return AdminDashboard();
                    } else {
                      // Navigate to the user dashboard
                      return UserDashboard();
                    }
                  }
                  return Text('Role not found');
                });
          }
        }
        ;
        return Auth_Page();
      },
    ));
  }

  Future<String?> getAdminName() async {
    try {
      QuerySnapshot adminCollection =
          await FirebaseFirestore.instance.collection('admin').get();
      String adminDocumentUID = adminCollection.docs.first.id;
      print(adminDocumentUID);
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('admin')
          .doc(adminDocumentUID)
          .get();

      if (adminSnapshot.exists) {
        String adminName = adminSnapshot.get('email');
        return adminName;
      } else {
        return "Admin document not found"; // Admin document not found
      }
    } catch (e) {
      print('Error retrieving admin name: $e');
      return null;
    }
  }
}
