import 'dart:developer';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> getSignedInUser() async {
    final User? user = auth.currentUser;
    return user;
    // here you write the codes to input the data into firestore
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, "/splash");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: getSignedInUser(),
          builder: ((context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircularProfileAvatar(
                          "${snapshot.data!.photoURL}",
                          errorWidget: (context, url, error) => Container(
                            child: Icon(Icons.error),
                          ),
                          placeHolder: (context, url) => Container(
                            width: 65,
                            height: 65,
                            child: CircularProgressIndicator(),
                          ),
                          radius: 36,
                          backgroundColor: Colors.transparent,
                          borderWidth: 1,
//                  initialsText: Text(
//                    "AD",
//                    style: TextStyle(fontSize: 40, color: Colors.white),
//                  ),
                          borderColor: Colors.yellowAccent,
                          imageFit: BoxFit.fitHeight,
                          elevation: 5.0,

                          cacheImage: true,
                          showInitialTextAbovePicture: false,
                        ),
                        Center(
                          child: (snapshot.data!.displayName != null)
                              ? Text(
                                  "${snapshot.data!.displayName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24.0),
                                )
                              : null,
                        ),
                        Center(
                          child: (snapshot.data!.email != null)
                              ? Text(
                                  "${snapshot.data!.email}",
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0),
                                )
                              : null,
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          child: const Divider(
                            height: 2.0,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        const CustomCard(
                            "Invite and Earn",
                            "Earn rush coins for every invite claimed.",
                            "/invite"),
                        const CustomCard(
                            "Completed challenges",
                            "Check all the previous challenges you completed",
                            "/challenges"),
                        const CustomCard("Purchase history",
                            "find about all your transactions", "/purchases"),
                        GestureDetector(
                          onTap: () => _signOut(),
                          child: Text("sign out"),
                        ),
                      ],
                    ),
                  ),
                );
              } // snapshot.data  :- get your object which is pass from your downloadData() function
            }
          }),
        ),
      ),
    );
  }
}
