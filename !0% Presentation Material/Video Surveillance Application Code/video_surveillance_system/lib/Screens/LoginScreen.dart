import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_surveillance_system/Auth/AuhData.dart';
import 'package:video_surveillance_system/Notifications/notificationService.dart';
import 'package:video_surveillance_system/Screens/Admin/AdminDashboard.dart';
import 'package:video_surveillance_system/Screens/Admin/DeleteUserScreen.dart';
import 'package:video_surveillance_system/Screens/Admin/AddUsers.dart';
import 'package:video_surveillance_system/Screens/SignUpScreen.dart';

import 'Users/UserDashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  NotificationServices services = NotificationServices();

  @override
  void initState() {
    super.initState();
    services.requestNotificationPermission();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? adminName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                //image(),
                const SizedBox(height: 270),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: email,
                              focusNode: _focusNode1,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.email,
                                  //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                                  color: Colors.white,
                                ),
                                hintText: 'Enter the Email',
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(
                                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                    .hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2, color: Colors.white),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Enter the Password",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 19),
                                icon: Icon(
                                  Icons.password,
                                  //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                                  color: Colors.white,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                //  account(),
                const SizedBox(height: 20),
                Login_bottom(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const SignUpScreen()));
            },
            child: const Text(
              'Sign UP',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget Login_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            AuthenticationRemote().login(email.text, password.text);

            // final user = _auth.currentUser;

            fetchAdminName();
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Text(
            'LogIn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage('images/2.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
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

  void fetchAdminName() async {
    String? result = await getAdminName();
    print('${result}cccccccccccccccccc');
    adminName = result;
    final user = _auth.currentUser;
    try {
      if (user != null) {
        if (user.email == adminName) {
          try {
            // Navigate to AdminDashboard screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboard(),
              ),
            );

            //    Display success toast message

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("SuccessFully loggin:"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          } catch (e) {
            // Handle navigation error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Failed loggin:"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          }
        } else {
          try {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => UserDashboard()));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text("SuccessFully loggin:"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Failed loggin:"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Not Found 404"),
        ),
      );
    }
  }
}
