import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/coin_card.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/store_item_list.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getSignedInUser() async {
    final User? user = auth.currentUser;
    return user;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    Widget horizontalList1 = Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
          ],
        ));

    Widget horizontalList2 = Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: 200.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
            const StoreItemCard(
                "Leaf Studio",
                "350rushcoins",
                "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                "asjadada"),
          ],
        ));
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              const ListTile(
                title: Text(
                  "Listen",
                  style: TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.w600),
                ),
              ),
              horizontalList1,
              const ListTile(
                title: Text(
                  "Walk in Style",
                  style: TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.w600),
                ),
              ),
              horizontalList2,
              const ListTile(
                title: Text(
                  "Big Bumper award",
                  style: TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.w600),
                ),
              ),
              const StoreItemCard(
                  "Leaf Studio",
                  "350rushcoins",
                  "https://d2d22nphq0yz8t.cloudfront.net/88e6cc4b-eaa1-4053-af65-563d88ba8b26/https://media.croma.com/image/upload/v1605267027/Croma%20Assets/Entertainment/Headphones%20and%20Earphones/Images/8944937500702.png/mxw_1650,f_auto",
                  "asjadada"),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
