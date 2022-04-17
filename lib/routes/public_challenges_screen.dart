import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class PublicChallengesPage extends StatefulWidget {
  const PublicChallengesPage({Key? key}) : super(key: key);

  @override
  _PublicChallengesPageState createState() => _PublicChallengesPageState();
}

class _PublicChallengesPageState extends State<PublicChallengesPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: const <Widget>[
            Center(
              child: Text("Public challenges", style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }
}
