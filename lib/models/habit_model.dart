import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String habitName;
  final String habitId;
  final String habitNotes;

  // final String email;
  // final String name;
  // final String phoneNumber;
  // final String profilePictureUrl;
  // final Timestamp createdAt;

  const Habit(this.habitName, this.habitId, this.habitNotes
      //  this.email,
      //   this.name,
      //   this.phoneNumber,
      //     this.profilePictureUrl,
      //this.createdAt
      );

  factory Habit.fromDocument(DocumentSnapshot document) {
    return Habit(
        document['habitName'], document['habitId'], document['habitNotes']
        // document['email'],
        // document['name'],
        // document['phoneNumber'],
        // document['profilePictureUrl'],
        //document['createdAt']
        );
  }
}
