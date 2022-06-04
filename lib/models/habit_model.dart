import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitrush/models/habit_timeOffset.dart';
import 'package:objectbox/objectbox.dart';

@Entity()

//
//     "habitRemindAt": _remindMeAtList
//         .map((e) => DateFormat("HH:mm").format(e.toLocal()))
//         .toList(),

class Habit {
  //system
  int id;

//newly created
  Timestamp habitCreatedOn;
  String habitReminderFrequency;
  Timestamp habitLastCompletedAtDate;
  List<HabitOffset> habitCreatedTimeOffset;
  bool active;
  bool archive;
  Timestamp habitStartDate;
  List<String> habitRemindAt;

//existing
  String habitName;
  String habitId;
  String habitNotes;

  // final String email;
  // final String name;
  // final String phoneNumber;
  // final String profilePictureUrl;
  // final Timestamp createdAt;

//this.id = 0,

  Habit({
    this.id = 0,
    required this.habitName,
    required this.habitId,
    required this.habitNotes,
    required this.habitCreatedOn,
    required this.habitReminderFrequency,
    required this.habitLastCompletedAtDate,
    required this.habitCreatedTimeOffset,
    required this.active,
    required this.archive,
    required this.habitStartDate,
    required this.habitRemindAt,
  });

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
      habitNotes: document['habitNotes'],
      habitCreatedOn: document['habitCreatedOn'],
      habitReminderFrequency: document['habitReminderFrequency'],
      habitLastCompletedAtDate: document['habitLastCompletedAtDate'],
      habitCreatedTimeOffset: document['habitCreatedTimeOffset'],
      active: document['active'],
      archive: document['archive'],
      habitStartDate: document['habitStartDate'],
      habitRemindAt: document['habitRemindAt'],
    );
  }
}
