import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userName;
  final String email;
  final String name;
  final String phoneNumber;
  final String profilePictureUrl;
  final Timestamp creationDate;

  const User(this.userName, this.email, this.name, this.phoneNumber,
      this.profilePictureUrl, this.creationDate);

  factory User.fromDocument(DocumentSnapshot document) {
    return User(
        document['userName'],
        document['email'],
        document['name'],
        document['phoneNumber'],
        document['profilePictureUrl'],
        document['creationDate']);
  }
}
