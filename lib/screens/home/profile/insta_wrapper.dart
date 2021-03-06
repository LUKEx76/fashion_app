import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/profile/insta_login.dart';
import 'package:fashion_app/screens/home/profile/insta_picture_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstaWrapper extends StatelessWidget {
  final Profile profile;

  InstaWrapper({this.profile});

  @override
  Widget build(BuildContext context) {
    final IgAccessToken accessToken = Provider.of<IgAccessToken>(context) ??
        IgAccessToken(igAccessToken: "", igUserId: "");
    //Check if user has valid Access Token
    if (accessToken.igAccessToken.length == 0) {
      return Container(
        child: Center(
          child: RaisedButton(
            child: Text("Connect to Instagram"),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => InstaLogin())),
          ),
        ),
      );
    } else {
      return InstaPictureDisplay(profile: profile);
    }
  }
}
