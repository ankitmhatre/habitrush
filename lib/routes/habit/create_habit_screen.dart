import 'dart:convert';
import 'dart:developer';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/text_input.dart';
import 'package:habitrush/extra/demo_toggle_buttons.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:lottie/lottie.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({Key? key}) : super(key: key);

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  List<bool> isSelected = [true, false, false, false];

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getHabits() async {
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    // Call the user's CollectionReference to add a new user
    var allhabits = await habits.get();
    print(allhabits.docs.map((e) => json.decode(json.encode(e.data()))));
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "New habit",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        body: FutureBuilder<User?>(
          future: getHabits(),
          builder: ((context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        //HABIT NAME
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextInputWidget(
                            hint: "Enter habit name",
                            initialText: "",
                            inputKey: "habitName"),

                        //HABIT REPEAT
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 36, bottom: 8, left: 8, right: 8),
                          child: Text(
                            "Repeat habit",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        DemoToggleButtons(),

                        //REMIND ME AT
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 36, bottom: 8, left: 8, right: 8),
                          child: Text(
                            "Remind me at",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextInputWidget(
                            hint: "Add reminder at",
                            initialText: "",
                            inputKey: "habitReminder"),

                        //HABIT START DATE
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 36, bottom: 8, left: 8, right: 8),
                          child: Text(
                            "Start date",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextInputWidget(
                            hint: "April 22",
                            initialText: "",
                            inputKey: "habitStartDate"),

                        //HABIT NOTES
                        const Padding(
                          padding: EdgeInsets.only(
                              top: 36, bottom: 8, left: 8, right: 8),
                          child: Text(
                            "Notes",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        TextInputWidget(
                            hint: "Add Notes",
                            initialText: "",
                            inputKey: "habitNotes"),

                        Container(
                          decoration: BoxDecoration(
                            color: rushYellow,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.only(top: 24, bottom: 15),
                          height: 50,
                          child: Center(
                              child: Text(
                            "Go for it!",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          )),
                        )
                      ],
                    ),
                  ),
                );
              } // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          }),
        ),
      ),
    );
  }
}
