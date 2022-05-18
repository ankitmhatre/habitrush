import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/models/reminder_model.dart';
import 'package:habitrush/objectbox.g.dart';

import 'package:habitrush/routes/completeschallenges_screen.dart';
import 'package:habitrush/routes/habit/create_habit_screen.dart';
import 'package:habitrush/routes/habitDetails_screen.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/routes/invite_screen.dart';
import 'package:habitrush/routes/login_screen.dart';
import 'package:habitrush/routes/profile_screen.dart';
import 'package:habitrush/routes/purchases_screen.dart';
import 'package:habitrush/routes/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitrush/utilities/globalObjectBox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';

import 'dart:io';
import 'dart:async';

import 'package:path_provider_ios/path_provider_ios.dart';

late ObjectBox globalObjectBox;

Future<void> _messageHandler(RemoteMessage message) async {
  print('_messageHandler ' + "${message.data['payload']}");

  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  if (Platform.isIOS) PathProviderIOS.registerWith();

  switch (message.data['type'].toString()) {
    case "habitReminder":
      var habitRem = HabitReminder.fromJson(message.data['payload']);

      globalObjectBox = await ObjectBox.create();
      final habitReminderBox = globalObjectBox.store.box<HabitReminder>();
      habitReminderBox.put(habitRem);
      final habitReminders = habitReminderBox.getAll();
      print("habitReminders $habitReminders");
      globalObjectBox.store.close();
      break;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: false,
  );
  // globalObjectBox = await ObjectBox.create();
  // var person = HabitReminder(
  //     habitName: 'Joe',
  //     completeStatus: 'Joe',
  //     remindAtInLocalTime: 'Joe',
  //     createdAt: 'Joe',
  //     habitId: 'Green');

  // final habitReminderBox = globalObjectBox.store.box<HabitReminder>();
  // final habitReminders = habitReminderBox.getAll();
  // habitReminders.forEach((element) => print(element.habitId));
  // print("habitReminders $habitReminders");
  // final id = habitReminderBox.put(person);
  // print("id $id");

  FirebaseFirestore.instance.useFirestoreEmulator("192.168.1.203", 8080);
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessage.listen(_messageHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('onMessageAppOpened ${message.data}');
  });

  // final store = await openStore();
  // final habitReminderBox = store.box<HabitReminder>();

//   var person = Habit(hab: 'Joe', lastName: 'Green');
//   print(person);
//   final id = box.put(person); // Create
//   print(id);
//   person = box.get(id)!; // Read
//   print(person);
//   person.lastName = "Black";
//   box.put(person); // Update
//   print(person);
//   box.remove(person.id); // Delete
//   print(person);
// // find all people whose name start with letter 'J'
//   final query = box.query(Person_.firstName.startsWith('J')).build();
//   final people = query.find(); // find() returns List<Person>

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/purchases': (context) => const PurchasesPage(),
        '/invite': (context) => const InvitePage(),
        '/createHabit': (context) => const CreateHabitPage(),
        '/challenges': (context) => const CompletedChallengesPage(),
        '/habitDetails': (context) => const HabitDetailsPage(),
      },
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          fontFamily: 'Poppins',
          colorScheme: _customColorScheme),
    );
  }
}

ColorScheme _customColorScheme = ColorScheme(
  primary: Color.fromARGB(255, 255, 221, 100),
  secondary: Colors.amber,
  surface: Colors.purpleAccent,
  background: Colors.white,
  error: Colors.red,
  onPrimary: Colors.black,
  onSecondary: Colors.blueAccent,
  onSurface: Colors.green,
  onBackground: Colors.black,
  onError: Colors.redAccent,
  brightness: Brightness.light,
);
