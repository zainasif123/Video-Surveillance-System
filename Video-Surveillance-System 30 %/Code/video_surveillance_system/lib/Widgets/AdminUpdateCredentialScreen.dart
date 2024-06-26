import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmnewPasswordController = TextEditingController();
  String _errorMessage = '';

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmnewPasswordController.dispose();
    super.dispose();
  }

  var auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  var firestore = FirebaseFirestore.instance;

  Future<void> updatePassword(
      {required String email,
      required String oldPassword,
      required String newPassword}) async {
    var cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newPassword);

      // Update password in Firestore
      await firestore
          .collection('admin')
          .doc(currentUser!.uid)
          .update({'password': newPassword});
      setState(() {
        _errorMessage = 'Password updated successfully';
      });

      // Navigate to LoginScreen after successful password update
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    } catch (error) {
      if (error is FirebaseAuthException &&
          (error.code == 'wrong-password' || error.code == 'user-mismatch')) {
        setState(() {
          _errorMessage = 'The old password is incorrect.';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect old password. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        setState(() {
          _errorMessage = "Please enter the correct old password";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image(),
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
                        controller: _oldPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter the old Password",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                          labelText: 'Old Password',
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 19),
                          icon: Icon(
                            Icons.password,
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
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
                        controller: _newPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter the New Password",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                          labelText: 'New Password',
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 19),
                          icon: Icon(
                            Icons.password,
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
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
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
                SizedBox(height: 10),
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
                        controller: _confirmnewPasswordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter the Confirm Password",
                          hintStyle:
                              TextStyle(color: Colors.black54, fontSize: 15),
                          labelText: 'Confirm Password',
                          labelStyle:
                              TextStyle(color: Colors.black54, fontSize: 19),
                          icon: Icon(
                            Icons.password,
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
                              RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value);
                          if (!hasSpecialCharacter) {
                            return 'Password must contain at least one special character';
                          }
                          // Check for at least one digit
                          bool hasDigit = RegExp(r'\d').hasMatch(value);
                          if (!hasDigit) {
                            return 'Password must contain at least one digit';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                update_bottom(),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget update_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            await updatePassword(
              email: "admin@gmail.com",
              oldPassword: _oldPasswordController.text,
              newPassword: _newPasswordController.text,
            );
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
            'Update Password',
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
        height: 100,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/reset-icon.png'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
