import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Auth/AuhData.dart';
import 'package:video_surveillance_system/Screens/Admin/AdminDashboard.dart';

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

  @override
  void initState() {
    super.initState();

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

  var auth = FirebaseAuth.instance;
  var firestore = FirebaseFirestore.instance;
  String _errorMessage = 'Invalid Login Credentials';
  Future<void> login() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Check if user is an admin
        DocumentSnapshot adminSnapshot =
            await firestore.collection('admin').doc(user.uid).get();
        if (adminSnapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Login successful! Welcome, Admin"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 600.0),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => AdminDashboard()));
          return;
        }

        // Check if user is a normal user
        DocumentSnapshot userSnapshot =
            await firestore.collection('users').doc(user.uid).get();
        if (userSnapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("Login successful! Welcome, User"),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.only(bottom: 600.0),
            ),
          );
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => UserDashboard()));
          return;
        }

        // If user is neither admin nor normal user
        setState(() {
          _errorMessage = 'No matching user role found.';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(_errorMessage),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 20.0),
          ),
        );
      }
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          //content: Text("Login Failed! $_errorMessage"),
          content: Text("Invalid Login Credentials"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 20.0),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            image(),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black38),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: email,
                          focusNode: _focusNode1,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.black,
                            ),
                            hintText: 'Enter the Email',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            labelText: 'Email',
                            labelStyle:
                                TextStyle(color: Colors.black54, fontSize: 19),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(
                                    r'^(?!.*[A-Z])[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 2, color: Colors.black26),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Enter the Password",
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            labelText: 'Password',
                            labelStyle:
                                TextStyle(color: Colors.black54, fontSize: 19),
                            icon: Icon(
                              Icons.password,
                              //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                              color: Colors.black,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            // Check for at least one special character
                            bool hasSpecialCharacter =
                                RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(value);
                            if (!hasSpecialCharacter) {
                              return 'Password must contain at least one special character';
                            }
                            // Check for at least one digit
                            bool hasDigit = RegExp(r'\d').hasMatch(value);
                            if (!hasDigit) {
                              return 'Password must contain at least one digit';
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
            const SizedBox(height: 20),
            Login_bottom(),
          ],
        ),
      ),
    );
  }

  Widget Login_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            //AuthenticationRemote().login(email.text, password.text, context);
            await login();
            // fetchAdminName();
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black45, width: 2),
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
            image: AssetImage('images/logo.png'),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("No Internet COnnection"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 600.0),
          ),
        ); // Admin document not found
      }
    } catch (e) {
      print('Error retrieving admin name: $e');
      return null;
    }
  }

  void fetchAdminName() async {
    String? result = await getAdminName();
    //String result = "admin@gmail.com";
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
                content: Text("Login successful! Welcome"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          } catch (e) {
            // Handle navigation error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Login Failed!"),
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
                content: Text("Login successful! Welcome"),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 600.0),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text("Login Failed!"),
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
          backgroundColor: Colors.red,
          content: Text("No Internet Connection"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 600.0),
        ),
      );
    }
  }
}
