// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:video_surveillance_system/Auth/AuhData.dart';
// import 'package:video_surveillance_system/Screens/Admin/AdminDashboard.dart';

// class AddUsers extends StatefulWidget {
//   const AddUsers({super.key});

//   @override
//   State<AddUsers> createState() => _AddUsersState();
// }

// class _AddUsersState extends State<AddUsers> {
//   final FocusNode _focusNode1 = FocusNode();
//   final FocusNode _focusNode2 = FocusNode();

//   final email = TextEditingController();
//   final password = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _focusNode1.addListener(() {
//       setState(() {});
//     });
//     _focusNode2.addListener(() {
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     email.dispose();
//     password.dispose();
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           _showCustomAlertDialog(context);
//         },
//       ),
//       backgroundColor: Colors.white70,
//       appBar: AppBar(
//         backgroundColor: Colors.white70,
//         title: Text("Add User"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection('users').snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return CircularProgressIndicator();
//                 }

//                 final List<DocumentSnapshot> documents = snapshot.data!.docs;

//                 return ListView.builder(
//                   itemCount: documents.length,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final data =
//                         documents[index].data() as Map<String, dynamic>;
//                     final email = data['email'];
//                     final password = data['password'];

//                     return Card(
//                       elevation: 5, // Set the elevation for the card
//                       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.all(16),
//                         leading: Image.asset("images/profile.png"),
//                         title: Text(
//                           'Email: $email',
//                           style: TextStyle(fontSize: 18, color: Colors.black),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Password: $password',
//                               style:
//                                   TextStyle(fontSize: 16, color: Colors.black),
//                             ),
//                             SizedBox(height: 8),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 8.0, bottom: 8),
//                 //   child: ElevatedButton(
//                 //     onPressed: () {
//                 //       Navigator.of(context).push(MaterialPageRoute(
//                 //         builder: (BuildContext context) => AdminDashboard(),
//                 //       ));
//                 //     },
//                 //     child: Text(
//                 //       "Back",
//                 //       style: TextStyle(fontSize: 16, color: Colors.black),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showCustomAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Dialog(
//             backgroundColor: Colors.white70,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(32.0),
//             ),
//             child: Container(
//               width: MediaQuery.of(context).size.width / 1.3,
//               height: MediaQuery.of(context).size.height / 2.2,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Contents of your custom AlertDialog here
//                   Text(
//                     'ADD USER',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border:
//                                   Border.all(width: 2, color: Colors.black38),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 5),
//                               child: TextFormField(
//                                 controller: email,
//                                 focusNode: _focusNode1,
//                                 decoration: const InputDecoration(
//                                   icon: Icon(
//                                     Icons.email,
//                                     //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
//                                     color: Colors.black,
//                                   ),
//                                   hintText: 'Enter the Email',
//                                   labelText: 'Email',
//                                 ),
//                                 keyboardType: TextInputType.emailAddress,
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please enter your email';
//                                   }
//                                   if (!RegExp(
//                                           r'^(?!.*[A-Z])[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
//                                       .hasMatch(value)) {
//                                     return 'Please enter a valid email address';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15),
//                               border:
//                                   Border.all(width: 2, color: Colors.black38),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.only(left: 5),
//                               child: TextFormField(
//                                 controller: password,
//                                 obscureText: true,
//                                 decoration: const InputDecoration(
//                                   labelText: 'Password',
//                                   icon: Icon(
//                                     Icons.password,
//                                     //color: _focusNode.hasFocus ? custom_green : Color(0xffc5c5c5),
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value!.isEmpty) {
//                                     return 'Please enter your password';
//                                   }
//                                   if (value.length < 6) {
//                                     return 'Password must be at least 6 characters long';
//                                   }
//                                   // Check for at least one special character
//                                   bool hasSpecialCharacter =
//                                       RegExp(r'[!@#$%^&*(),.?":{}|<>]')
//                                           .hasMatch(value);
//                                   if (!hasSpecialCharacter) {
//                                     return 'Password must contain at least one special character';
//                                   }
//                                   // Check for at least one digit
//                                   bool hasDigit = RegExp(r'\d').hasMatch(value);
//                                   if (!hasDigit) {
//                                     return 'Password must contain at least one digit';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.of(context).pop(); // Close the AlertDialog
//                         },
//                         child: Text(
//                           'Close',
//                           style: TextStyle(fontSize: 17, color: Colors.black),
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             AuthenticationRemote()
//                                 .registerusers(email.text, password.text);
//                             Navigator.of(context).pop();
//                           }
//                         },
//                         child: Text(
//                           'Add',
//                           style: TextStyle(fontSize: 17, color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_surveillance_system/Auth/AuhData.dart'; // Assuming this is where your AuthenticationRemote class is

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
  String? errorMessage;

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
    email.dispose();
    password.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showCustomAlertDialog(context);
        },
      ),
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text("Add User"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<DocumentSnapshot> documents = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: documents.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final data =
                        documents[index].data() as Map<String, dynamic>;
                    final email = data['email'];
                    final password = data['password'];

                    return Card(
                      elevation: 5, // Set the elevation for the card
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: Image.asset("images/profile.png"),
                        title: Text(
                          'Email: $email',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password: $password',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //         builder: (BuildContext context) => AdminDashboard(),
                //       ));
                //     },
                //     child: Text(
                //       "Back",
                //       style: TextStyle(fontSize: 16, color: Colors.black),
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Dialog(
            backgroundColor: Colors.white70,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 2.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ADD USER',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.red, fontSize: 16),
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
                              border:
                                  Border.all(width: 2, color: Colors.black38),
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
                                  labelText: 'Email',
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
                              border:
                                  Border.all(width: 2, color: Colors.black38),
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
                                  bool hasSpecialCharacter =
                                      RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                          .hasMatch(value);
                                  if (!hasSpecialCharacter) {
                                    return 'Password must contain at least one special character';
                                  }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the AlertDialog
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await AuthenticationRemote().registerusers(
                                  context, email.text, password.text);
                              Navigator.of(context).pop();
                            } catch (e) {
                              // Handle error
                            }
                          }
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(fontSize: 17, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Update your AuthenticationRemote class to throw exceptions when registration fails

class AuthenticationRemote {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> registerusers(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Save user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'password': password,
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(e.message ?? 'An error occurred'),
        ),
      );
      throw e;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('An error occurred: $e'),
        ),
      );
      throw FirebaseAuthException(
        code: 'unknown',
        message: e.toString(),
      );
    }
  }
}
