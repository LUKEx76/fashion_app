import 'package:fashion_app/screens/home/profil/insta_login.dart';
import 'package:fashion_app/screens/home/profil/insta_picture_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstaWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String accessToken = Provider.of<String>(context);
    //Check if user has valid Access Token
    if (accessToken.length < 10) {
      print("InstaWrapper: " + accessToken);
      return RaisedButton(
        child: Text("Connect to Instagram"),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => InstaLogin())),
      );
    } else {
      return InstaPictureDisplay();
    }
  }
}
