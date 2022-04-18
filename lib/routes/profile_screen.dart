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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User?>(
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: FadeInImage.assetNetwork(
                            placeholder: "assets/images/profile_default.svg",
                            image: "${snapshot.data!.photoURL}"),
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
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        child: const Divider(
                          height: 2.0,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      CustomCard("Invite and Earn",
                          "Earn rush coins for every invite claimed."),
                      CustomCard("Completed challenges",
                          "Check all the previous challenges you completed"),
                      CustomCard("Purchase history",
                          "find about all your transactions"),
                    ],
                  ),
                ),
              );
            } // snapshot.data  :- get your object which is pass from your downloadData() function
          }
        }),
      ),
    );
  }
}
