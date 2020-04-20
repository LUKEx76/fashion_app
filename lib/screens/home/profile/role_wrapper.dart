import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/profile/role_display.dart';
import 'package:fashion_app/screens/home/profile/role_picker.dart';
import 'package:flutter/material.dart';

class RoleWrapper extends StatelessWidget {
  final Profile profile;

  RoleWrapper({this.profile});

  @override
  Widget build(BuildContext context) {
    //If Role is picked, display it
    //Else show RolePicker
    if (profile == null) {
      //kept throwing a Exception because mainRole was null
      return RolePicker(profile: profile);
    } else {
      if (profile.mainRole.length == 0) {
        return RolePicker(profile: profile);
      } else {
        return RoleDisplay(profile: profile);
      }
    }
  }
}
