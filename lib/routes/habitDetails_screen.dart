import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/coin_card.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/store_item_list.dart';
import 'package:habitrush/models/habit_model.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

class HabitDetailsPage extends StatefulWidget {
  final Habit habit;
  const HabitDetailsPage({Key? key, required this.habit}) : super(key: key);

  @override
  _HabitDetailsPageState createState() => _HabitDetailsPageState();
}

class _HabitDetailsPageState extends State<HabitDetailsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getSignedInUser() async {
    final User? user = auth.currentUser;
    return user;
    // here you write the codes to input the data into firestore
  }

  Future<List<Habit>> getHabits() async {
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    // Call the user's CollectionReference to add a new user
    var allhabits = await habits.get();
    print(allhabits);
    var allHabitsMap =
        allhabits.docs.map((e) => Habit.fromDocument(e)).toList();

    return allHabitsMap;

    // here you write the codes to input the data into firestore
  }

  Future<void> deleteHabit(String habitId) {
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');
//todo: delete all teh reminders from Object box
    return habits.doc(habitId).delete();
  }

  Future<void> archiveHabit(String habitId) {
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    return habits.doc(habitId).update({"archive": true});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(widget.habit.habitName),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Container(
                child: InkWell(
                  splashColor: rushYellow,
                  radius: 50,
                  onTap: () {},
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: PopupMenuButton(
                          onSelected: (int index) {
                            switch (index) {
                              case 0:
                                Navigator.pushNamed(context, '/createHabit',
                                        arguments: widget.habit.habitId)
                                    .then((_) => setState(() {}));

                                break;
                              case 1:
                                Dialogs.bottomMaterialDialog(
                                    titleStyle: TextStyle(
                                      // color: Colors.amber[600],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    title:
                                        "Are you sure, that you want to delete this habit?",
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'No, don\'t delete',
                                        textStyle:
                                            TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                      IconsButton(
                                        onPressed: () {
                                          deleteHabit(widget.habit.habitId)
                                              .then((value) =>
                                                  {Navigator.pop(context)});
                                          Navigator.pop(context);
                                        },
                                        text: 'Yes, delete',
                                        iconData: Icons.check,
                                        color: Colors.red,
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                        iconColor: Colors.white,
                                      ),
                                    ]);
                                break;
                              case 2:
                                Dialogs.bottomMaterialDialog(
                                    titleStyle: TextStyle(
                                      // color: Colors.amber[600],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    title:
                                        "Are you sure, that you want to archive this habit?",
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'No, don\'t archive',
                                        textStyle:
                                            TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                      IconsButton(
                                        onPressed: () {
                                          archiveHabit(widget.habit.habitId)
                                              .then((value) =>
                                                  {Navigator.pop(context)});
                                          Navigator.pop(context);
                                        },
                                        text: 'Yes, Archive',
                                        iconData: Icons.check,
                                        color: Colors.red[300],
                                        textStyle:
                                            TextStyle(color: Colors.black),
                                        iconColor: Colors.black,
                                      ),
                                    ]);
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text("Edit"),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text("Delete"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: Text("Archive"),
                                  value: 2,
                                )
                              ]),
                    ),
                  ),
                ),
              )
            ]),
        body: FutureBuilder<List<Habit>>(
          future: getHabits(),
          builder: ((context, AsyncSnapshot<List<Habit>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                    child: Column(
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 18),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Completion Graph",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 28),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 8,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    "Apr 2022",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Card(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  elevation: 8,
                                  child: Center(
                                    child: Container(
                                      height: 96,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                              child: Text(
                                            "Current Streak",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          )),
                                          Center(
                                              child: Text(
                                            "4 days",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24),
                                          )),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: Card(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                elevation: 8,
                                child: Center(
                                  child: Container(
                                    height: 96,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Longest Streak",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                            "221 days",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 24),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
            }
          }),
        ),
      ),
    );
  }
}
