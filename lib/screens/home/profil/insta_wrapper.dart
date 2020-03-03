import 'package:fashion_app/screens/home/profil/insta_login.dart';
import 'package:fashion_app/screens/home/profil/insta_picture_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InstaWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);  look if user has a valid insta access token
    if (true) {
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
