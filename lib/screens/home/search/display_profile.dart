import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/profile/insta_picture_display.dart';
import 'package:fashion_app/screens/home/profile/profile_info_display.dart';
import 'package:fashion_app/screens/home/profile/role_display.dart';
import 'package:flutter/material.dart';

class DisplayProfile extends StatelessWidget {
  final Profile profile;

  DisplayProfile({this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ProfileInfoDisplay(profile: profile),
          RoleDisplay(profile: profile),
          InstaPictureDisplay(profile: profile),
        ],
      ),
    );
  }
}
