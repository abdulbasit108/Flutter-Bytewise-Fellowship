import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:photo_app/model/users.dart';
import 'package:photo_app/screens/sign_in_screen.dart';

import '../utils/upload_dialog.dart';
import '../utils/utils.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

Future<Users> getUserData() async {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  QuerySnapshot querySnapshot =
      await usersCollection.where('email', isEqualTo: user.email).get();
  Users userData = Users(
    email: '',
    name: '',
  );
  if (querySnapshot.docs.isNotEmpty) {
    Users data = Users.fromFirestore(querySnapshot.docs[0]);
    userData = data;
  }
  return userData;
}

class _FeedScreenState extends State<FeedScreen> {
  late Future<Users> _futureUserData;

  final auth = FirebaseAuth.instance;
  CollectionReference posts = FirebaseFirestore.instance.collection('posts');

  @override
  void initState() {
    super.initState();
    _futureUserData = getUserData();
  }

  void uploadPhoto(name) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(name: name);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Users>(
        future: _futureUserData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred while loading data.'),
            );
          } else {
            final userData = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      auth.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                    },
                    icon: Icon(Icons.logout)),
                title: Text('FEED'),
                backgroundColor: Color.fromRGBO(145, 131, 222, 1),
              ),
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    uploadPhoto(userData.name);
                  },
                  backgroundColor: Color.fromRGBO(160, 148, 227, 1),
                  child: Icon(
                    Icons.add,
                  )),
              body: Column(
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream: posts.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }

                      return Expanded(
                        child: ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(width: 3),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Image.network(
                                      data['imageUrl'].toString(),
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.fill,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('@' + data['user'].toString()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          }
        });
  }
}
