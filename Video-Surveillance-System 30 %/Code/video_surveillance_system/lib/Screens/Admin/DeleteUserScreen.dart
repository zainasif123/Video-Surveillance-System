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
      backgroundColor: Colors.white70,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Delete User"),
        backgroundColor: Colors.white70,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  final email = data['email'];
                  final password = data['password'];
                  return Card(
                    elevation: 5, // Set the elevation for the card
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: Image.asset("images/profile.png"),
                      contentPadding: EdgeInsets.all(16),
                      title: Text('Email: $email',
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                      subtitle: Text('Password: $password',
                          style: TextStyle(fontSize: 15, color: Colors.black)),
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
                }).toList(),
              );
            },
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
                    )),
                ElevatedButton(
                  onPressed: () {
                    for (String userId in selectedUserIds) {
                      deleteUser(userId);
                    }
                  },
                  child: Text('Delete Selected Users',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
