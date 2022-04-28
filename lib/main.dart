import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/routes/completeschallenges_screen.dart';
import 'package:habitrush/routes/habit/create_habit_screen.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/routes/invite_screen.dart';
import 'package:habitrush/routes/login_screen.dart';
import 'package:habitrush/routes/profile_screen.dart';
import 'package:habitrush/routes/purchases_screen.dart';
import 'package:habitrush/routes/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('onMes_BackgroundMessage  ${message.data}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseFirestore.instance.useFirestoreEmulator("192.168.1.203", 8080);
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessage.listen(_messageHandler);

  FirebaseMessaging.onMessageOpenedApp.listen((message) {
    print('onMessageAppOpened ${message.data}');
  });
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
