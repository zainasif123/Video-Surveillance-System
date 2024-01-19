import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:video_surveillance_system/Auth/AuhData.dart';
import 'package:video_surveillance_system/Screens/LoginScreen.dart';
import 'package:video_surveillance_system/Widgets/Drawer.dart';

class AddUsers extends StatefulWidget {
  const AddUsers({super.key});

  @override
  State<AddUsers> createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add User"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Administration"),
            // Image.asset(
            //   "images/cctv.png",
            //   width: 100,
            //   height: 100,
            // )
          ],
        ),
        Text("Administrator"),
        Text("Administrator"),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              itemCount: documents.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final data = documents[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['email']),
                  subtitle: Text(data['password']),
                );
              },
            );
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showCustomAlertDialog(context);
          }),
    );
  }

  void _showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.3,
            height: MediaQuery.of(context).size.height / 2.1,
            child: Column(
              children: [
                // Contents of your custom AlertDialog here
                Text(
                  'ADD USER',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2, color: Colors.black),
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
                                  color: Colors.black,
                                ),
                                hintText: 'Enter the Email',
                                labelText: 'Email',
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 2, color: Colors.black),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: TextFormField(
                              controller: password,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
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
                                return null;
                              },
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 15),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(15),
                      //       border: Border.all(width: 2, color: Colors.black),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 5),
                      //       child: TextFormField(
                      //         controller: PasswordConfirm,
                      //         obscureText: true,
                      //         decoration: const InputDecoration(
                      //           labelText: 'Confirm Password',
                      //           icon: Icon(
                      //             Icons.password,
                      //             //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
                      //             color: Colors.black,
                      //           ),
                      //         ),
                      //         validator: (value) {
                      //           if (value!.isEmpty) {
                      //             return 'Please enter your password';
                      //           }
                      //           if (value.length < 6) {
                      //             return 'Password must be at least 6 characters long';
                      //           }

                      //           return null;
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the AlertDialog
                      },
                      child: Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          AuthenticationRemote()
                              .registerusers(email.text, password.text);
                          email.clear();
                          password.clear();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text('ADD'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
