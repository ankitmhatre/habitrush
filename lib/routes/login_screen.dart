import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  Future<User?> _handleSignIn({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final fcmToken = await FirebaseMessaging.instance.getToken();
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        var firestoreInstance = FirebaseFirestore.instance;

        CollectionReference users = firestoreInstance.collection('users');

        // Call the user's CollectionReference to add a new user
        users
            .doc(user?.uid)
            .set({
              'displayName': user?.displayName, // John Doe
              'email': user?.email, // Stokes and Sons
              'uid': user?.uid, // 42
              'photoURL': user?.photoURL,
              'token': fcmToken // 42
            }, SetOptions(merge: true))
            .then((value) => print("User Added"))
            .catchError((error) => print("Failed to add user: $error"));

        Navigator.pushReplacementNamed(context, '/home', arguments: user);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // ...
        } else if (e.code == 'invalid-credential') {
          // ...
        }
      } catch (e) {
        // ...
      }
    }

    return user;
  }

  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: SignInButton(Buttons.Google, onPressed: () {
            _handleSignIn(context: context);
          }),
        ),
      ),
    );
  }
}
