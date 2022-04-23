import 'package:flutter/material.dart';

class StoreItemCard extends StatelessWidget {
  final String titleText;

  final String amountText;
  final String id;
  final String photoUrl;

  const StoreItemCard(this.titleText, this.amountText, this.photoUrl, this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(photoUrl, width: 96, fit: BoxFit.fill),
          Text(
            titleText,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          Text(
            amountText,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12.0,
                backgroundColor: Color.fromARGB(255, 220, 220, 220)),
          ),
        ],
      ),
    );
  }
}
