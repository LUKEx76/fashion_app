import 'package:fashion_app/models/profile.dart';
import 'package:flutter/material.dart';

class RoleDisplay extends StatelessWidget {
  final Profile profile;

  RoleDisplay({this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile?.mainRole?.length == 0) {
      return Container(
        child: Text("No Role picked yet"),
      );
    }
    //Display the Role
    if (profile?.secondaryRole?.length == 0) {
      return Container(
        child: Text("Main Role: ${profile.mainRole}"),
      );
    } else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text("Main Role: ${profile.mainRole}"),
            SizedBox(height: 5),
            Text("Secondary Role: ${profile.secondaryRole}"),
          ],
        ),
      );
    }
  }
}
