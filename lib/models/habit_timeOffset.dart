import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class HabitOffset {
  //system
  int id;

//newly created
  bool n;
  int m;
//this.id = 0,

  HabitOffset({this.id = 0, required this.n, required this.m});

  // const Habit(this.habitName, this.habitId, this.habitNotes
  //     //  this.email,
  //     //   this.name,
  //     //   this.phoneNumber,
  //     //     this.profilePictureUrl,
  //     //this.createdAt
  //     );

  factory HabitOffset.fromDocument(DocumentSnapshot document) {
    return HabitOffset(
      n: document['n'],
      m: document['m'],
    );
  }
}
