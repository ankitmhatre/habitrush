import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/grayed_form_button.dart';
import 'package:habitrush/components/text_input.dart';
import 'package:habitrush/models/habit_model.dart';

import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateHabitPage extends StatefulWidget {
  final String habitId;

  const CreateHabitPage({Key? key, required this.habitId}) : super(key: key);

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  final TextEditingController habitNameTextController = TextEditingController();

  final TextEditingController everyXDaysTextController =
      TextEditingController();
  final TextEditingController notesTextController = TextEditingController();
  final TextEditingController startDateTextController = TextEditingController();

  List<bool> isSelected = [false, false, false, false];
  bool isLoading = false;
  String habitId = "";
  String isLoadingStatus = "Creating your customized habit";
  List<String> reminderTypeSelection = [
    "Everyday",
    "Every x days",
    "Weekly",
    "Monthly"
  ];
  List<DateTime> _remindMeAtList = [];
  DateTime startDate = DateTime.now().toUtc();
  List<String> daysOFWeek = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
  List<bool> selectedDaysOfWeek = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];
  List<String> daysOfMonth = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31"
  ];
  List<bool> selectedDaysOfMonth = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  int everyXDaysNumber = 1;
  var reminderFrequencyDays = ["1"];
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void createOrUpdateHabit(RoundedLoadingButtonController controller) async {
    setState(() {
      isLoadingStatus = "Creating your customized habit";
      isLoading = true;
    });
    final FirebaseAuth auth = FirebaseAuth.instance;

    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    // Call the user's CollectionReference to add a new user
    //var addHabitsReponse = await habits.add({});

    if (isSelected.indexOf(true) == 0) {
      reminderFrequencyDays = ["1"];
    } else if (isSelected.indexOf(true) == 1) {
      print(everyXDaysTextController.text);
      reminderFrequencyDays = [everyXDaysTextController.text];
    } else if (isSelected.indexOf(true) == 2) {
      reminderFrequencyDays = daysOFWeek
          .where((day) => (selectedDaysOfWeek[daysOFWeek.indexOf(day)]))
          .toList();
    } else if (isSelected.indexOf(true) == 3) {
      reminderFrequencyDays = daysOfMonth
          .where((day) => (selectedDaysOfMonth[daysOfMonth.indexOf(day)]))
          .toList();
    }

    DateTime dateTime = DateTime.now();

    Habit habit = Habit(
        habitName: habitNameTextController.text,
        habitId: "",
        habitNotes: notesTextController.text,
        habitCreatedOn: dateTime.toUtc(),
        habitReminderFrequencyDays: List<String>.from(reminderFrequencyDays),
        habitReminderFrequency: reminderTypeSelection[isSelected.indexOf(true)],
        habitCreatedTimeOffset_n: dateTime.timeZoneOffset.isNegative,
        habitCreatedTimeOffset_m: dateTime.timeZoneOffset.inMinutes,
        active: true,
        archive: false,
        habitStartDate: startDate.toUtc(),
        habitRemindAt: _remindMeAtList
            .map((e) => DateFormat("HH:mm").format(e.toLocal()))
            .toList());

    try {
      if (widget.habitId.isEmpty) {
        //CREATE A NEW HABIT

        var habitId = await habits.doc().id;
        habit.habitId = habitId;
        var habitAddResponse = await habits
            .doc(habitId)
            .set(Habit.toMap(habit))
            .timeout(Duration(seconds: 7));
      } else {
        //UPDATE THE OLD HABIT

        habit.habitId = widget.habitId;
        var habitAddResponse = await habits
            .doc(habit.habitId)
            .update(Habit.toMap(habit))
            .timeout(Duration(seconds: 7));
      }

      controller.success();
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    } catch (e) {
      setState(() {
        isLoadingStatus =
            "We apologize, there was some problem at our end.\nTry restarting the app";
      });
      print(e);

      controller.error();
      Timer(Duration(seconds: 4), () {
        setState(() {
          isLoading = false;
        });
        controller.reset();
      });
    }
  }

  Future<DocumentSnapshot> getSpecificHabit(String habitId) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    CollectionReference habits = FirebaseFirestore.instance
        .collection('users/${auth.currentUser!.uid}/habits');

    var specificHabitInFuture = await habits.doc(habitId).get();
    Habit specificHabit = Habit.fromDocument(specificHabitInFuture);

    //update UI elements to this update habit
    habitNameTextController.text = specificHabit.habitName;
    notesTextController.text = specificHabit.habitNotes;
    startDate = specificHabit.habitStartDate.toUtc();
    startDateTextController.text = DateFormat("MMMM dd yyy")
        .format(specificHabit.habitStartDate.toLocal());

    setState(() {
      isSelected[reminderTypeSelection
          .indexOf(specificHabit.habitReminderFrequency)] = true;
    });

    switch (isSelected.indexOf(true)) {
      case 0:
        setState(() {
          reminderFrequencyDays = ["1"];
        });

        break;
      case 1:
        setState(() {
          reminderFrequencyDays = specificHabit.habitReminderFrequencyDays;
        });
        everyXDaysTextController.text =
            specificHabit.habitReminderFrequencyDays[0];
        break;
      case 2:
        specificHabit.habitReminderFrequencyDays.forEach((element) {
          setState(() {
            selectedDaysOfWeek[daysOFWeek.indexOf(element)] = true;
          });
        });

        break;
      case 3:
        specificHabit.habitReminderFrequencyDays.forEach((element) {
          setState(() {
            selectedDaysOfMonth[daysOfMonth.indexOf(element)] = true;
          });
        });

        break;
    }

    //print(specificHabit.habitReminderFrequencyDays);
    print("---------------");
    print("_remindMeAtList");
    print(_remindMeAtList);

    print(specificHabit.habitRemindAt);

    specificHabit.habitRemindAt.forEach((element) {
      var hm = element.split(":");
      DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, int.parse(hm[0]), int.parse(hm[1]));
      setState(() {
        _remindMeAtList.add(dateToday);
      });
    });

    print("---------------");
    /**
     * Habit habit = Habit(
        
        
     
        habitCreatedOn: dateTime.toUtc(),
        habitReminderFrequencyDays: List<String>.from(reminderFrequencyDays),
        habitReminderFrequency: reminderTypeSelection[isSelected.indexOf(true)],
        habitCreatedTimeOffset_n: dateTime.timeZoneOffset.isNegative,
        habitCreatedTimeOffset_m: dateTime.timeZoneOffset.inMinutes,
        active: true,
        archive: false,
        habitStartDate: startDate.toUtc(),
        habitRemindAt: _remindMeAtList
            .map((e) => DateFormat("HH:mm").format(e.toLocal()))
            .toList());
     */

    setState(() {
      isLoading = false;
    });
    return specificHabitInFuture;
  }

  @override
  void initState() {
    if (widget.habitId.isNotEmpty) {
      setState(() {
        isLoading = true;
        isLoadingStatus = "Getting your habit details";
        habitId = widget.habitId;
      });
      getSpecificHabit(widget.habitId);
    } else {
      startDateTextController.text =
          DateFormat("MMMM dd yyy").format(startDate.toLocal());
      setState(() {
        isSelected[0] = true;

        _remindMeAtList.add(DateTime.now().toUtc());
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    habitNameTextController.dispose();
    everyXDaysTextController.dispose();
    notesTextController.dispose();
    startDateTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IgnorePointer(
          ignoring: isLoading,
          child: Stack(children: [
            // Positioned.fill(
            //   child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //       child: Container(color: Colors.black.withOpacity(0.5))),
            // ),
            (isLoading
                ? Center(
                    child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SpinKitThreeBounce(color: rushYellow, size: 50.0),
                        Center(
                          child: Text(
                            isLoadingStatus,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
                : Text("")),
            Opacity(
              opacity: isLoading ? 0.3 : 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            "${widget.habitId.isEmpty ? "Create a new " : "Update "}habit",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                        ),
                      ),
                      //HABIT NAME
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color.fromARGB(255, 232, 232, 232),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            keyboardType: TextInputType.name,
                            controller: habitNameTextController,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter habit name",
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),

                      //HABIT REPEAT
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 36, bottom: 8, left: 8, right: 8),
                        child: Text(
                          "Repeat habit",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Ink(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: GridView.count(
                          primary: true,
                          crossAxisCount:
                              2, //set the number of buttons in a row to 2
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio:
                              3, //set the width-to-height ratio of the button,
                          //>1 is a horizontal rectangle
                          children: List.generate(isSelected.length, (index) {
                            //using Inkwell widget to create a button
                            return InkWell(
                              //the default splashColor is grey
                              onTap: () {
                                //set the toggle logic
                                setState(() {
                                  for (int indexBtn = 0;
                                      indexBtn < isSelected.length;
                                      indexBtn++) {
                                    if (indexBtn == index) {
                                      isSelected[indexBtn] = true;
                                    } else {
                                      isSelected[indexBtn] = false;
                                    }
                                  }
                                });
                              },
                              child: Ink(
                                decoration: BoxDecoration(
                                  //set the background color of the button when it is selected/ not selected
                                  color: isSelected[index]
                                      ? rushYellow
                                      : Color.fromARGB(255, 232, 232, 232),
                                  // here is where we set the rounded corner
                                  borderRadius: BorderRadius.circular(8),
                                  //don't forget to set the border,
                                  //otherwise there will be no rounded corner
                                ),
                                child: Center(
                                  child: Text(
                                    reminderTypeSelection[index],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: isSelected[index]
                                          ? Colors.black
                                          : Color.fromARGB(100, 0, 0, 0),
                                    ),

                                    //set the color of the icon when it is selected/ not selected
                                    // color: isSelected[index] ? Colors.blue : Colors.grey
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      (isSelected[1]
                          ? Container(
                              margin: EdgeInsets.only(top: 24),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                color: const Color.fromARGB(255, 232, 232, 232),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: everyXDaysTextController,
                                  cursorColor: Colors.deepOrange,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Number of days",
                                    hintStyle: TextStyle(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                          : Text("")),

                      (isSelected[2]
                          ? Center(
                              child: Container(
                                child: GridView.count(
                                  primary: true,

                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 1,

                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: daysOFWeek.length,
                                  // Generate 100 widgets that display their index in the List.
                                  children:
                                      List.generate(daysOFWeek.length, (index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedDaysOfWeek[index] =
                                              !selectedDaysOfWeek[index];
                                        });
                                      },
                                      child: Ink(
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: selectedDaysOfWeek[index]
                                                  ? rushYellow
                                                  : grayField,
                                            ),
                                            child: Center(
                                              child: Text(
                                                daysOFWeek[index],
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            )
                          : Text("")),

                      (isSelected[3]
                          ? Center(
                              child: Container(
                                child: GridView.count(
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),

                                  // Create a grid with 2 columns. If you change the scrollDirection to
                                  // horizontal, this produces 2 rows.
                                  crossAxisCount: 7,
                                  children: List.generate(daysOfMonth.length,
                                      (index) {
                                    return InkWell(
                                      splashColor: rushYellow,
                                      onTap: () {
                                        setState(() {
                                          //uncomment this to allow only one selection
                                          // for (int indexBtn = 0;
                                          //     indexBtn < selectedDaysOfMonth.length;
                                          //     indexBtn++) {
                                          //  if (indexBtn == index) {
                                          selectedDaysOfMonth[index] =
                                              !selectedDaysOfMonth[index];
                                          // } else {
                                          // selectedDaysOfMonth[indexBtn] = false;
                                          // }
                                          // }
                                        });
                                      },
                                      child: Ink(
                                        child: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(9),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: selectedDaysOfMonth[index]
                                                  ? rushYellow
                                                  : Color.fromARGB(
                                                      255, 232, 232, 232),
                                            ),
                                            child: Center(
                                              child: Text(
                                                daysOfMonth[index],
                                                style: TextStyle(
                                                    color: black,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            )
                          : Text("")),
                      //REMIND ME AT
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 36, bottom: 4, left: 8, right: 8),
                        child: Text(
                          "Remind me at",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      SizedBox(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _remindMeAtList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: AppBar().preferredSize.height,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: grayField,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 8,
                                        child: Text(
                                          DateFormat("h:mm a").format(
                                              _remindMeAtList[index].toLocal()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            print(index);
                                            _remindMeAtList.removeAt(index);
                                          });
                                        },
                                        child: Icon(Icons.close),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),

                      InkWell(
                        onTap: () {
                          // DatePicker.showTime12hPicker(context,
                          //     theme: const DatePickerTheme(
                          //       headerColor: rushYellow,
                          //       backgroundColor: rushYellow,
                          //       itemStyle: TextStyle(
                          //           color: black,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: 18),
                          //       doneStyle:
                          //           TextStyle(color: black, fontSize: 16),
                          //     ),
                          //     showTitleActions: true, onConfirm: (date) {
                          //   setState(() {
                          //     _remindMeAtList.add(date.toUtc());
                          //   });
                          // }, currentTime: DateTime.now());

                          // setState(() {});
                        },
                        child: Ink(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            height: AppBar().preferredSize.height,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: grayFieldDark,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    "Set time at",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    Icons.add,
                                    color: black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //HABIT START DATE
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 36, bottom: 8, left: 8, right: 8),
                        child: Text(
                          "Start date",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          // DatePicker.showDatePicker(context,
                          //     showTitleActions: true,
                          //     minTime: DateTime.now(),
                          //     theme: const DatePickerTheme(
                          //         headerColor: rushYellow,
                          //         backgroundColor: rushYellow,
                          //         itemStyle: TextStyle(
                          //             color: black,
                          //             fontWeight: FontWeight.bold,
                          //             fontSize: 18),
                          //         doneStyle:
                          //             TextStyle(color: black, fontSize: 16)),
                          //     onChanged: (date) {
                          //   print('change $date in time zone ' +
                          //       date.timeZoneOffset.inHours.toString());
                          // }, onConfirm: (date) {
                          //   setState(() {
                          //     startDate = date.toUtc();
                          //     startDateTextController.text =
                          //         DateFormat("MMMM dd yyy")
                          //             .format(startDate.toLocal());
                          //   });
                          // }, currentTime: startDate, locale: LocaleType.en);
                        },
                        child: Container(
                          height: AppBar().preferredSize.height,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: grayField,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Start date"),
                                    enabled: false,
                                    controller: startDateTextController,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  )),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {},
                                  child: Icon(Icons.arrow_right_alt),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      //HABIT NOTES
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 36, bottom: 8, left: 8, right: 8),
                        child: Text(
                          "Notes",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color.fromARGB(255, 232, 232, 232),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            keyboardType: TextInputType.name,
                            controller: notesTextController,
                            cursorColor: Colors.deepOrange,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Add Notes",
                              hintStyle: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
                        child: RoundedLoadingButton(
                          borderRadius: 10,
                          color: rushYellow,
                          successColor: Colors.green,
                          successIcon: Icons.check,
                          failedIcon: Icons.close,
                          child: Text(
                            "Go for it!",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          controller: _btnController1,
                          onPressed: () => createOrUpdateHabit(_btnController1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
