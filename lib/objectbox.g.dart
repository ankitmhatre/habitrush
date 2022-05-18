// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'models/habit_model.dart';
import 'models/reminder_model.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2431143533606798915),
      name: 'Habit',
      lastPropertyId: const IdUid(4, 6536067236502458496),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4998524084807139285),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2044816295047048870),
            name: 'habitName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7612339781509748760),
            name: 'habitId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6536067236502458496),
            name: 'habitNotes',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 3081932666957069253),
      name: 'HabitReminder',
      lastPropertyId: const IdUid(6, 8596674190385458488),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3242665978638877472),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4850334236734039620),
            name: 'createdAt',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6568354922546627935),
            name: 'habitId',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9189416969446763635),
            name: 'habitName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8710937860068884028),
            name: 'completeStatus',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8596674190385458488),
            name: 'remindAtInLocalTime',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 3081932666957069253),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Habit: EntityDefinition<Habit>(
        model: _entities[0],
        toOneRelations: (Habit object) => [],
        toManyRelations: (Habit object) => {},
        getId: (Habit object) => object.id,
        setId: (Habit object, int id) {
          object.id = id;
        },
        objectToFB: (Habit object, fb.Builder fbb) {
          final habitNameOffset = fbb.writeString(object.habitName);
          final habitIdOffset = fbb.writeString(object.habitId);
          final habitNotesOffset = fbb.writeString(object.habitNotes);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, habitNameOffset);
          fbb.addOffset(2, habitIdOffset);
          fbb.addOffset(3, habitNotesOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Habit(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              habitName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              habitId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              habitNotes: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''));

          return object;
        }),
    HabitReminder: EntityDefinition<HabitReminder>(
        model: _entities[1],
        toOneRelations: (HabitReminder object) => [],
        toManyRelations: (HabitReminder object) => {},
        getId: (HabitReminder object) => object.id,
        setId: (HabitReminder object, int id) {
          object.id = id;
        },
        objectToFB: (HabitReminder object, fb.Builder fbb) {
          final habitIdOffset = fbb.writeString(object.habitId);
          final habitNameOffset = fbb.writeString(object.habitName);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.createdAt.millisecondsSinceEpoch);
          fbb.addOffset(2, habitIdOffset);
          fbb.addOffset(3, habitNameOffset);
          fbb.addBool(4, object.completeStatus);
          fbb.addInt64(5, object.remindAtInLocalTime.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = HabitReminder(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              habitName: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              habitId: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              completeStatus: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 12, false),
              remindAtInLocalTime: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0)),
              createdAt: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0)));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Habit] entity fields to define ObjectBox queries.
class Habit_ {
  /// see [Habit.id]
  static final id = QueryIntegerProperty<Habit>(_entities[0].properties[0]);

  /// see [Habit.habitName]
  static final habitName =
      QueryStringProperty<Habit>(_entities[0].properties[1]);

  /// see [Habit.habitId]
  static final habitId = QueryStringProperty<Habit>(_entities[0].properties[2]);

  /// see [Habit.habitNotes]
  static final habitNotes =
      QueryStringProperty<Habit>(_entities[0].properties[3]);
}

/// [HabitReminder] entity fields to define ObjectBox queries.
class HabitReminder_ {
  /// see [HabitReminder.id]
  static final id =
      QueryIntegerProperty<HabitReminder>(_entities[1].properties[0]);

  /// see [HabitReminder.createdAt]
  static final createdAt =
      QueryIntegerProperty<HabitReminder>(_entities[1].properties[1]);

  /// see [HabitReminder.habitId]
  static final habitId =
      QueryStringProperty<HabitReminder>(_entities[1].properties[2]);

  /// see [HabitReminder.habitName]
  static final habitName =
      QueryStringProperty<HabitReminder>(_entities[1].properties[3]);

  /// see [HabitReminder.completeStatus]
  static final completeStatus =
      QueryBooleanProperty<HabitReminder>(_entities[1].properties[4]);

  /// see [HabitReminder.remindAtInLocalTime]
  static final remindAtInLocalTime =
      QueryIntegerProperty<HabitReminder>(_entities[1].properties[5]);
}
