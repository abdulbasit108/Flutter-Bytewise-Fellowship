import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String email;
  String name;

  Users({
    required this.email,
    required this.name,
    
  });

  factory Users.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Users(
      email: data['email'],
      name: data['name'],
      
    );
  }
}
