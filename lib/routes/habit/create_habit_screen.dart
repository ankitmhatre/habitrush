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
import 'package:habitrush/extra/demo_toggle_buttons.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:habitrush/utilities/colors.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CreateHabitPage extends StatefulWidget {
  const CreateHabitPage({Key? key}) : super(key: key);

  @override
  _CreateHabitPageState createState() => _CreateHabitPageState();
}

class _CreateHabitPageState extends State<CreateHabitPage> {
  List<bool> isSelected = [true, false, false, false];
  List<String> _remindMeAtList = [];
  String startDate = "April 19";

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
              DemoToggleButtons(),

              //REMIND ME AT
              const Padding(
                padding: EdgeInsets.only(top: 36, bottom: 8, left: 8, right: 8),
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

              GrayedFormWidget(
                  sequenceIdentifier: -1,
                  hint: "Add reminder at",
                  initialText: "",
                  icon: Icons.add,
                  iconClickListener: () {
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
                  inputKey: "habitReminder"),

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
