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

  Future<List<Habit>> getHabits() async {
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    // Call the user's CollectionReference to add a new user
    var allhabits = await habits.get();
    var allHabitsMap =
        allhabits.docs.map((e) => Habit.fromDocument(e)).toList();

    return allHabitsMap;

    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text("Habit"),
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: InkWell(
                    child: GestureDetector(
                      child: Row(
                        children: [Icon(Icons.add), Text("create")],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/createHabit');
                      },
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
                return Center(
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 6,
                        margin:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          snapshot.data![index].habitName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "🔥${snapshot.data![index].habitStreak}",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: GestureDetector(
                                          child: Icon(Icons.check)),
                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
