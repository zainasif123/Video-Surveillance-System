import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';

class DeleteUsers extends StatefulWidget {
  @override
  _DeleteUsersState createState() => _DeleteUsersState();
}

class _DeleteUsersState extends State<DeleteUsers> {
  List<String> selectedUserIds = [];

  void toggleSelectedUser(String userId) {
    if (selectedUserIds.contains(userId)) {
      setState(() {
        selectedUserIds.remove(userId);
      });
    } else {
      setState(() {
        selectedUserIds.add(userId);
      });
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).delete();
      await FirebaseAuth.instance.currentUser?.delete();
      print(
          'User with UID $userId deleted from Firestore and Firebase Authentication');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete User"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Your other widgets here

          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final List<DocumentSnapshot> documents = snapshot.data!.docs;

              return Column(
                children: documents.map((document) {
                  final data = document.data() as Map<String, dynamic>;
                  final userId = document.id;
                  final isSelected = selectedUserIds.contains(userId);

                  return ListTile(
                    title: Text(data['email']),
                    subtitle: Text(data['password']),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (bool? value) {
                        toggleSelectedUser(userId);
                      },
                    ),
                    onTap: () {
                      toggleSelectedUser(userId);
                    },
                  );
                }).toList(),
              );
            },
          ),

          ElevatedButton(
            onPressed: () {
              for (String userId in selectedUserIds) {
                deleteUser(userId);
              }
            },
            child: Text('Delete Selected Users'),
          ),
        ],
      ),
    );
  }
}
