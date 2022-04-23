import 'package:flutter/material.dart';

class TwoLineNumberBoxCard extends StatelessWidget {
  final String number;
  final String text;

  const TwoLineNumberBoxCard(this.number, this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        elevation: 8,
        margin: EdgeInsets.all(8),
        child: Container(
          height: 120,
          margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          child: Container(
            decoration: BoxDecoration(shape: BoxShape.rectangle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                        color: Color.fromARGB(255, 4, 37, 28)),
                  ),
                ),
                Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 4, 37, 28)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
