import 'package:habitrush/models/reminder_model.dart';
import 'package:habitrush/objectbox.g.dart'; // created by `flutter pub run build_runner build`

/// Provides access to the ObjectBox Store throughout the app.
///
/// Create this in the apps main function.
class ObjectBox {
  /// The Store of this app.
  late final Store store;

  /// A Box of notes.
  late final Box<HabitReminder> noteBox;

  /// A stream of all notes ordered by date.
  late final Stream<Query<HabitReminder>> queryStream;

  ObjectBox._create(this.store) {
    // noteBox = Box<HabitReminder>(store);

    // final qBuilder = noteBox.query()
    //   ..order(HabitReminder_.createdAt, flags: Order.descending);
    // queryStream = qBuilder.watch(triggerImmediately: true);
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore();
    return ObjectBox._create(store);
  }
}
