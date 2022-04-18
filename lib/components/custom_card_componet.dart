import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String titleText;
  final String subtitleText;

  const CustomCard(this.titleText, this.subtitleText);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      elevation: 8,
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(20),
        height: 120.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.album, size: 45),
              title: Text(
                titleText,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(subtitleText),
            ),
          ],
        ),
      ),
    );
  }
}
