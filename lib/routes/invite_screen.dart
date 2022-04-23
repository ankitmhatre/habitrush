import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/invitee_profile.dart';
import 'package:habitrush/components/transaction_card.dart';
import 'package:habitrush/components/two_line_number_square_card.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  _InvitePageState createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> with TickerProviderStateMixin {
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 10), () {
      controller.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Invite",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            tooltip: 'Close',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Row(
              children: const <Widget>[
                TwoLineNumberBoxCard("8", "invited"),
                TwoLineNumberBoxCard("40", "rush coins")
              ],
            ),
            const SizedBox(height: 30),
            const ListTile(
              title: Text(
                "How it works",
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "You and your friend will earn 5 coins each.\nMaximum 100 invites",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            ),
            const ListTile(
              title: Text(
                "Your Invites",
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.w600),
              ),
            ),
            Wrap(
              spacing: 15.0,
              direction: Axis.horizontal,
              runSpacing: 20.0,
              children: [
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
                InviteeProfileCard(
                    "https://i.picsum.photos/id/866/300/200.jpg?hmac=vwkhhp_0HQtgJfxWytDiH1t2GX4YyYyWs3_18hlicBY",
                    "Siddesh Pansare",
                    "uiad"),
              ],
            ),
            RoundedLoadingButton(
              color: Colors.deepOrange,
              successIcon: Icons.check,
              failedIcon: Icons.close,
              child: Text('Invite', style: TextStyle(color: Colors.white)),
              controller: _btnController1,
              onPressed: () => _doSomething(_btnController1),
            )
          ],
        ));
  }
}
