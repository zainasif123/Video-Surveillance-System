// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class DeleteUsers extends StatefulWidget {
//   @override
//   _DeleteUsersState createState() => _DeleteUsersState();
// }

// class _DeleteUsersState extends State<DeleteUsers> {
//   List<String> selectedUserIds = [];

//   void toggleSelectedUser(String userId) {
//     setState(() {
//       if (selectedUserIds.contains(userId)) {
//         selectedUserIds.remove(userId);
//       } else {
//         selectedUserIds.add(userId);
//       }
//     });
//   }

//   Future<void> deleteUser(String userId) async {
//     try {
//       await FirebaseFirestore.instance.collection('users').doc(userId).delete();
//       await FirebaseAuth.instance.currentUser?.delete();
//       print(
//           'User with UID $userId deleted from Firestore and Firebase Authentication');
//     } catch (e) {
//       print('Error deleting user: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       appBar: AppBar(
//         title: Text("Remove User"),
//         backgroundColor: Colors.white70,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('users').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final List<DocumentSnapshot> documents = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: documents.length,
//                   itemBuilder: (context, index) {
//                     final document = documents[index];
//                     final data = document.data() as Map<String, dynamic>;
//                     final userId = document.id;
//                     final isSelected = selectedUserIds.contains(userId);
//                     final email = data['email'];
//                     final password = data['password'];

//                     return Card(
//                       elevation: 5, // Set the elevation for the card
//                       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                       child: ListTile(
//                         leading: Image.asset("images/profile.png"),
//                         contentPadding: EdgeInsets.all(16),
//                         title: Text(
//                           'Email: $email',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         ),
//                         subtitle: Text(
//                           'Password: $password',
//                           style: TextStyle(fontSize: 15, color: Colors.black),
//                         ),
//                         trailing: Checkbox(
//                           value: isSelected,
//                           onChanged: (bool? value) {
//                             toggleSelectedUser(userId);
//                           },
//                         ),
//                         onTap: () {
//                           toggleSelectedUser(userId);
//                         },
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     "Back",
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     for (String userId in selectedUserIds) {
//                       deleteUser(userId);
//                     }
//                   },
//                   child: Text(
//                     'Delete User',
//                     style: TextStyle(fontSize: 16, color: Colors.black),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteUsers extends StatefulWidget {
  @override
  _DeleteUsersState createState() => _DeleteUsersState();
}

class _DeleteUsersState extends State<DeleteUsers> {
  List<String> selectedUserIds = [];

  void toggleSelectedUser(String userId) {
    if (!mounted)
      return; // Check if the widget is still mounted before calling setState
    setState(() {
      if (selectedUserIds.contains(userId)) {
        selectedUserIds.remove(userId);
      } else {
        selectedUserIds.add(userId);
      }
    });
  }

  Future<void> deleteUser(String userId, String email, String password) async {
    try {
      // Delete user from Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      print('User with UID $userId deleted from Firestore');

      // Authenticate the user to delete from Firebase Authentication
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      await userCredential.user?.delete();
      print('User with UID $userId deleted from Firebase Authentication');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text("Remove User"),
        backgroundColor: Colors.white70,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final data = document.data() as Map<String, dynamic>;
                    final userId = document.id;
                    final isSelected = selectedUserIds.contains(userId);
                    final email = data['email'];
                    final password = data['password'];

                    return Card(
                      elevation: 5, // Set the elevation for the card
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        leading: Image.asset("images/profile.png"),
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          'Email: $email',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        subtitle: Text(
                          'Password: $password',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (bool? value) {
                            toggleSelectedUser(userId);
                          },
                        ),
                        onTap: () {
                          toggleSelectedUser(userId);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (selectedUserIds.isEmpty) {
                      // Show a SnackBar if no users are selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          //content: Text("Login Failed! $_errorMessage"),
                          content: Text("Please Select a User to Delete"),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: 600.0),
                        ),
                      );
                      return;
                    }

                    // Make a local copy of selectedUserIds to avoid potential issues with async operations
                    List<String> usersToDelete = List.from(selectedUserIds);

                    for (String userId in usersToDelete) {
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(userId)
                          .get();
                      if (userDoc.exists) {
                        Map<String, dynamic> data =
                            userDoc.data() as Map<String, dynamic>;
                        String email = data['email'];
                        String password = data['password'];
                        await deleteUser(userId, email, password);
                      }
                    }

                    // Check if the widget is still mounted before calling setState
                    if (mounted) {
                      setState(() {
                        selectedUserIds.clear();
                      });
                    }
                  },
                  child: Text(
                    'Delete User',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
