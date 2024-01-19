// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:video_surveillance_system/Screens/LoginScreen.dart';
// import 'package:video_surveillance_system/const/adminUID.dart';

// class UpdateEmailPasswordScreen extends StatefulWidget {
//   @override
//   _UpdateEmailPasswordScreenState createState() =>
//       _UpdateEmailPasswordScreenState();
// }

// class _UpdateEmailPasswordScreen extends StatefulWidget {
//   @override
//   _UpdateEmailPasswordScreenState createState() =>
//       _UpdateEmailPasswordScreenState();
// }

// class _UpdateEmailPasswordScreenState extends State<UpdateEmailPasswordScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController newPasswordController = TextEditingController();
//   String errorMessage = '';

//   Future<void> updatePassword() async {
//     try {
//       final user = _auth.currentUser;
//       // Change the  password fireauth
//       await user!.updatePassword(newPasswordController.text).then((_) async {
//         await FirebaseFirestore.instance
//             .collection('admin')
//             .doc(adminuid)
//             .update({
//           'password': newPasswordController.text,
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("password updated successfully."),
//           ),
//         );
//         // Update the password in Firestore

//         await FirebaseAuth.instance.signOut();
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: ((context) => LoginScreen())));
//       }).catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(errorMessage),
//           ),
//         );
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Updates Password"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextField(
//               controller: newPasswordController,
//               decoration: InputDecoration(labelText: "New Password"),
//               obscureText: true,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: updatePassword,
//               child: Text("Update Password"),
//             ),
//             if (errorMessage.isNotEmpty)
//               Text(
//                 errorMessage,
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';
import 'package:video_surveillance_system/const/adminUID.dart';

class UpdateEmailPasswordScreen extends StatefulWidget {
  @override
  _UpdateEmailPasswordScreenState createState() =>
      _UpdateEmailPasswordScreenState();
}

class _UpdateEmailPasswordScreenState extends State<UpdateEmailPasswordScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  String errorMessage = '';

  Future<void> updateEmailAndPassword() async {
    try {
      final user = _auth.currentUser;

      // Update the email
      if (newEmailController.text.isNotEmpty) {
        await user!.updateEmail(newEmailController.text.toString());
      }

      // Update the password
      await user!.updatePassword(newPasswordController.text.toString());

      // Update the password in Firestore
      await FirebaseFirestore.instance
          .collection('admin')
          .doc(adminuid)
          .update({
        'email': newEmailController.text.toString(),
        'password': newPasswordController.text.toString(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Email and password updated successfully."),
        ),
      );

      // Sign out and navigate to the login screen
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => LoginScreen())),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        print(e);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Email and Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: newEmailController,
              decoration: InputDecoration(labelText: "New Email"),
            ),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(labelText: "New Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateEmailAndPassword,
              child: Text("Update Email and Password"),
            ),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
