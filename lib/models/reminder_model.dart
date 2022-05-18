import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

@JsonSerializable()
@Entity()
class HabitReminder {
  int id;

  DateTime createdAt;
  String habitId;
  String habitName;
  bool completeStatus;
  DateTime remindAtInLocalTime;

  HabitReminder(
      {this.id = 0,
      required this.habitName,
      required this.habitId,
      required this.completeStatus,
      required this.remindAtInLocalTime,
      required this.createdAt});

  factory HabitReminder.fromJson(Map<String, dynamic> json) {
    List<String> contents = json['content']['rendered'].toString().split('"');

    return HabitReminder(
        habitName: json['habitName'],
        habitId: json['habitId'],
        completeStatus: json['completeStatus'],
        remindAtInLocalTime: json['remindAtInLocalTime'],
        createdAt: json['createdAt']);
  }
}
