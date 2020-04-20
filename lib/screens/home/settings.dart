import 'package:fashion_app/shared/constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Text("Change Name:"),
              SizedBox(height: 10),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "New Name"),
                onChanged: (value) => print(value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
