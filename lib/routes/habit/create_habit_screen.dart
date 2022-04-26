import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/grayed_form_button.dart';
import 'package:habitrush/components/text_input.dart';

import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({Key? key}) : super(key: key);

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  List<bool> isSelected = [true, false, false, false];
  List<String> iconList = ["Everyday", "Every x days", "Weekly", "Monthly"];
  List<String> _remindMeAtList = [];
  String startDate = "April 19";
  List<String> daysOFWeek = ["S", "M", "T", "W", "T", "F", "S"];
  List<bool> selectedDaysOfWeek = [
    true,
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
    true,
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

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 3), () {
      controller.error();
      Timer(Duration(seconds: 2), () {
        controller.reset();
      });
    });
  }

  @override
  void initState() {
    final controller = TextEditingController();
    super.initState();
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //HABIT NAME
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                padding: EdgeInsets.only(top: 36, bottom: 8, left: 8, right: 8),
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
                  crossAxisCount: 2, //set the number of buttons in a row to 2
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
                            iconList[index],
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
                      child: TextInputWidget(
                          hint: "Number of days",
                          type: TextInputType.number,
                          initialText: "$everyXDaysNumber",
                          inputKey: "habitIntervalDays"),
                    )
                  : Text("")),

              (isSelected[2]
                  ? Center(
                      child: Container(
                        child: GridView.count(
                          primary: true,

                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 1,

                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          crossAxisCount: daysOFWeek.length,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(daysOFWeek.length, (index) {
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
                                            fontWeight: FontWeight.w800),
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
                          children: List.generate(daysOfMonth.length, (index) {
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
                                          : Color.fromARGB(255, 232, 232, 232),
                                    ),
                                    child: Center(
                                      child: Text(
                                        daysOfMonth[index],
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800),
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
                padding: EdgeInsets.only(top: 36, bottom: 4, left: 8, right: 8),
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
                                  _remindMeAtList[index],
                                  style: TextStyle(fontWeight: FontWeight.w700),
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
                  DatePicker.showTime12hPicker(context,
                      theme: const DatePickerTheme(
                        headerColor: rushYellow,
                        backgroundColor: rushYellow,
                        itemStyle: TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle: TextStyle(color: black, fontSize: 16),
                      ),
                      showTitleActions: true, onConfirm: (date) {
                    String confirmedTime = DateFormat("h:mma").format(date);

                    setState(() {
                      _remindMeAtList.add(confirmedTime);
                    });
                  }, currentTime: DateTime.now());

                  // setState(() {});
                },
                child: Ink(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    height: AppBar().preferredSize.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: grayFieldDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Text(
                            "Set time at",
                            style: TextStyle(fontWeight: FontWeight.w700),
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
                padding: EdgeInsets.only(top: 36, bottom: 8, left: 8, right: 8),
                child: Text(
                  "Start date",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),

              GestureDetector(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      theme: const DatePickerTheme(
                          headerColor: rushYellow,
                          backgroundColor: rushYellow,
                          itemStyle: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle: TextStyle(color: black, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date in time zone ' +
                        date.timeZoneOffset.inHours.toString());
                  }, onConfirm: (date) {
                    setState(() {
                      startDate = DateFormat("MMM dd").format(date);
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Container(
                  height: AppBar().preferredSize.height,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                            startDate,
                            style: TextStyle(fontWeight: FontWeight.w700),
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
                padding: EdgeInsets.only(top: 36, bottom: 8, left: 8, right: 8),
                child: Text(
                  "Notes",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              TextInputWidget(
                  hint: "Add Notes", initialText: "", inputKey: "habitNotes"),

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
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  controller: _btnController1,
                  onPressed: () => _doSomething(_btnController1),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
