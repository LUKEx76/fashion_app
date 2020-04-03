import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/search/display_profile.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  ProfileTile({this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 10.0,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayProfile(
                  profile: profile,
                ),
              ),
            ),
            child: ListTile(
              leading: profile.profilePicture.length == 0
                  ? Icon(
                      Icons.person,
                      size: 50.0,
                    )
                  : Image.network(
                      profile.profilePicture ?? "",
                    ),
              title: Text(profile.name),
              subtitle: Text("//ROLE"),
            ),
          ),
        ),
      );
    }
  }
}
