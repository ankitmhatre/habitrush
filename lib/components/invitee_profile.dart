import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

class InviteeProfileCard extends StatelessWidget {
  final String photourl;
  final String name;
  final String uid;

  const InviteeProfileCard(this.photourl, this.name, this.uid);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularProfileAvatar(
          photourl,
          errorWidget: (context, url, error) => Container(
            child: Icon(Icons.error),
          ),
          placeHolder: (context, url) => Container(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(),
          ),
          radius: 30,
          backgroundColor: Colors.transparent,
          borderWidth: 1,
//                  initialsText: Text(
//                    "AD",
//                    style: TextStyle(fontSize: 40, color: Colors.white),
//                  ),
          borderColor: Colors.red,
          imageFit: BoxFit.fitHeight,
          elevation: 5.0,
          onTap: () {
            print(uid);
          },
          cacheImage: true,
          showInitialTextAbovePicture: false,
        ),
        Text(
          name,
          style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 9,
              color: Color.fromARGB(255, 4, 37, 28)),
        ),
      ],
    );
  }
}
