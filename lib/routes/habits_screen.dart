import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/coin_card.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/store_item_list.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getSignedInUser() async {
    final User? user = auth.currentUser;
    return user;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Habits"),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
        ),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: const <Widget>[
              // ListTile(
              //   title: Text(
              //     "Habits",
              //     style: TextStyle(
              //         color: Colors.deepOrange, fontWeight: FontWeight.w600),
              //   ),
              // ),
              // ListTile(
              //   title: Text(
              //     "Walk in Style",
              //     style: TextStyle(
              //         color: Colors.deepOrange, fontWeight: FontWeight.w600),
              //   ),
              // ),
              // ListTile(
              //   title: Text(
              //     "Big Bumper award",
              //     style: TextStyle(
              //         color: Colors.deepOrange, fontWeight: FontWeight.w600),
              //   ),
              // ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
