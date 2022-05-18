import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Habit {
  int id;

  String habitName;
  String habitId;
  String habitNotes;

  // final String email;
  // final String name;
  // final String phoneNumber;
  // final String profilePictureUrl;
  // final Timestamp createdAt;

//this.id = 0,

  Habit(
      {this.id = 0,
      required this.habitName,
      required this.habitId,
      required this.habitNotes});

  // const Habit(this.habitName, this.habitId, this.habitNotes
  //     //  this.email,
  //     //   this.name,
  //     //   this.phoneNumber,
  //     //     this.profilePictureUrl,
  //     //this.createdAt
  //     );

  factory Habit.fromDocument(DocumentSnapshot document) {
    return Habit(
        habitId: document['habitId'],
        habitName: document['habitName'],
        habitNotes: document['habitNotes']);
    // document['habitName'], document['habitId'], document['habitNotes']
    // // document['email'],
    // // document['name'],
    // // document['phoneNumber'],
    // // document['profilePictureUrl'],
    // //document['createdAt']
  }
}
