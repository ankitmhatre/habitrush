import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/complete_challenge_card.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/transaction_card.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class CompletedChallengesPage extends StatefulWidget {
  const CompletedChallengesPage({Key? key}) : super(key: key);

  @override
  _CompletedChallengesPageState createState() =>
      _CompletedChallengesPageState();
}

class _CompletedChallengesPageState extends State<CompletedChallengesPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Challenges",
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
      body: Center(
        child: ListView(
          children: const <Widget>[
            CompletedChallengesCard(
                "daily walking challenge", "20 Jan", "2", "RC"),
            CompletedChallengesCard(
                "daily walking challenge", "7 Oct", "8", "RC"),
          ],
        ),
      ),
    );
  }
}
