import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    if (FirebaseAuth.instance.currentUser != null) {
      // wrong call in wrong place!
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Lottie.asset(
              'assets/lottie_files/star_watch.json',
            ),
            const Center(
              child: Text("HabitRush", style: TextStyle(fontSize: 48)),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/login',
                  );
                },
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
