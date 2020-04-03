import 'package:fashion_app/models/profile.dart';
import 'package:flutter/material.dart';

class ProfileInfoDisplay extends StatelessWidget {
  final Profile profile;

  ProfileInfoDisplay({this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile != null) {
      return Container(
        height: 100,
        child: Center(
          child: Text("${profile.name}"),
        ),
      );
    } else {
      return Container(
        height: 100,
        child: Text("No Data"),
      );
    }
  }
}
