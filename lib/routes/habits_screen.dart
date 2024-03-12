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
    print("called getHabits");

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              Container(
                child: InkWell(
                  splashColor: rushYellow,
                  radius: 50,
                  onTap: () {
                    Navigator.pushNamed(context, '/createHabit', arguments: '')
                        .then((_) => setState(() {}));
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [Icon(Icons.add), Text("create")],
                      ),
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
                  child: RefreshIndicator(
                    onRefresh: getHabits,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 6,
                          margin: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Container(
                            color: Colors.teal,
                            height: 96,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: GestureDetector(
                                      onTap: () => {
                                        Navigator.pushNamed(
                                            context, '/habitDetails',
                                            arguments: snapshot.data![index])
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data![index].habitName,

                                              style: const TextStyle(
                                                color: Colors.black87,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              "${snapshot.data![index].habitNotes}",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: GestureDetector(
                                          child: Row(
                                        children: const [
                                          Center(
                                            child: Icon(
                                              Icons.local_fire_department,
                                              color: Colors.amber,
                                              size: 18,
                                            ),
                                          ),
                                          Center(
                                              child: Text(
                                            "27",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ))
                                        ],
                                      )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () => {
                                        Dialogs.bottomMaterialDialog(
                                            titleStyle: TextStyle(
                                              // color: Colors.amber[600],
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            title:
                                                "Mark \"${snapshot.data![index].habitName}\" complete for the rest of the day?",
                                            context: context,
                                            actions: [
                                              IconsOutlineButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'complete',
                                                textStyle: TextStyle(
                                                    color: Colors.grey),
                                                iconColor: Colors.grey,
                                              ),
                                              IconsButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Only this time',
                                                iconData: Icons.check,
                                                color: Colors.greenAccent,
                                                textStyle: TextStyle(
                                                    color: Colors.white),
                                                iconColor: Colors.white,
                                              ),
                                            ]),
                                      },
                                      child: Ink(
                                        child: Center(
                                          child: Icon(
                                            Icons.check_rounded,
                                            color: Colors.amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
