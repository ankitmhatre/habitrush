import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Habit {
  int id;
  String habitName;
  String habitId;
  String habitNotes;
  @Property(type: PropertyType.date)
  DateTime habitCreatedOn;
  String habitReminderFrequency;
  @Property(type: PropertyType.date)
  DateTime? habitLastCompletedAtDate;
  bool habitCreatedTimeOffset_n;
  int habitCreatedTimeOffset_m;
  bool active;
  bool archive;
  @Property(type: PropertyType.date)
  DateTime habitStartDate;
  List<String> habitRemindAt;

  Habit({
    this.id = 0,
    required this.habitName,
    required this.habitId,
    required this.habitNotes,
    required this.habitCreatedOn,
    required this.habitReminderFrequency,
    required this.habitCreatedTimeOffset_n,
    required this.habitCreatedTimeOffset_m,
    required this.active,
    required this.archive,
    required this.habitStartDate,
    required this.habitRemindAt,
    this.habitLastCompletedAtDate,
  });

  // const Habit(this.habitName, this.habitId, this.habitNotes
  //     //  this.email,
  //     //   this.name,
  //     //   this.phoneNumber,
  //     //     this.profilePictureUrl,
  //     //this.createdAt
  //     );

  factory Habit.fromDocument(DocumentSnapshot document) {
    //  print(document['habitCreatedTimeOffset']);

    return Habit(
      habitId: document['habitId'],
      habitName: document['habitName'],
      habitNotes: document['habitNotes'],
      habitCreatedOn: document['habitCreatedOn'].toDate(),
      habitReminderFrequency: document['habitReminderFrequency'],
      habitCreatedTimeOffset_n: document['habitCreatedTimeOffset_n'],
      habitCreatedTimeOffset_m: document['habitCreatedTimeOffset_m'],
      active: document['active'],
      archive: document['archive'],
      habitStartDate: document['habitStartDate'].toDate(),
      habitRemindAt: List<String>.from(document['habitRemindAt']),
    );
  }
}
