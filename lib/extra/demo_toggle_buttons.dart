import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habitrush/utilities/colors.dart';

class DemoToggleButtons extends StatefulWidget {
  @override
  _DemoToggleButtonsState createState() => _DemoToggleButtonsState();
}

class _DemoToggleButtonsState extends State<DemoToggleButtons> {
  //set the initial state of each button whether it is selected or not
  List<bool> isSelected = [true, false, false, false];
  List<String> iconList = ["Everyday", "Every x days", "Weekly", "Monthly"];

  @override
  Widget build(BuildContext context) {
    //wrap the GridView wiget in an Ink wiget and set the width and height,
    //otherwise the GridView widget will fill up all the space of its parent widget
    return Ink(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: GridView.count(
        primary: true,
        crossAxisCount: 2, //set the number of buttons in a row to 2
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        childAspectRatio: 3, //set the width-to-height ratio of the button,
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
    );
  }
}
