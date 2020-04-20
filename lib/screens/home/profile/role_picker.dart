import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/settings.dart';
import 'package:flutter/material.dart';

class RolePicker extends StatelessWidget {
  final Profile profile;

  RolePicker({this.profile});

  @override
  Widget build(BuildContext context) {
    //Pick a Role and Save it to the DataBase
    return Container(
      child: RaisedButton(
        child: Text("Pick a Role"),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => Settings())),
      ),
    );
  }
}
