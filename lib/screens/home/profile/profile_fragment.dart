import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/profile/insta_wrapper.dart';
import 'package:fashion_app/screens/home/profile/profile_info_display.dart';
import 'package:fashion_app/screens/home/profile/role_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ProfileInfoDisplay(profile: profile),
        RoleWrapper(profile: profile),
        //Either Log in with insta or Display Profil
        InstaWrapper(profile: profile),
      ],
    );
  }
}
