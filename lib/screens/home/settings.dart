import 'package:fashion_app/services/database.dart';
import 'package:fashion_app/shared/constants.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final DatabaseService _databaseService = DatabaseService();
  String mainRoleValue;
  String secondaryRoleValue;
  String newName;

  @override
  void initState() {
    super.initState();
    mainRoleValue = "";
    secondaryRoleValue = "";
    newName = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Text(
                "Change Name:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "New Name"),
                onChanged: (value) => setState(() => newName = value),
              ),
              SizedBox(height: 40),
              Text(
                "Choose a Role:",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text("Main Role"),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Model
                    Card(
                      color: Colors.indigoAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "💃🏻",
                                groupValue: mainRoleValue,
                                onChanged: (val) =>
                                    setState(() => mainRoleValue = val),
                              ),
                              Text("💃🏻  "),
                            ],
                          ),
                          Text(
                            "Model",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //Photographer
                    Card(
                      color: Colors.amberAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "📸",
                                groupValue: mainRoleValue,
                                onChanged: (val) =>
                                    setState(() => mainRoleValue = val),
                              ),
                              Text("📸  "),
                            ],
                          ),
                          Text(
                            "Photographer",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //MakeUp Artist
                    Card(
                      color: Colors.lightGreenAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "💄",
                                groupValue: mainRoleValue,
                                onChanged: (val) =>
                                    setState(() => mainRoleValue = val),
                              ),
                              Text("💄  "),
                            ],
                          ),
                          Text(
                            "MakeUp Artist",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //Designer
                    Card(
                      color: Colors.redAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "👗",
                                groupValue: mainRoleValue,
                                onChanged: (val) =>
                                    setState(() => mainRoleValue = val),
                              ),
                              Text("👗  "),
                            ],
                          ),
                          Text(
                            "Designer",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text("Secondary Role"), //SECONDARY
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Model
                    Card(
                      color: Colors.indigoAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "💃🏻",
                                groupValue: secondaryRoleValue,
                                onChanged: (val) =>
                                    setState(() => secondaryRoleValue = val),
                              ),
                              Text("💃🏻  "),
                            ],
                          ),
                          Text(
                            "Model",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //Photographer
                    Card(
                      color: Colors.amberAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "📸",
                                groupValue: secondaryRoleValue,
                                onChanged: (val) =>
                                    setState(() => secondaryRoleValue = val),
                              ),
                              Text("📸  "),
                            ],
                          ),
                          Text(
                            "Photographer",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //MakeUp Artist
                    Card(
                      color: Colors.lightGreenAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "💄",
                                groupValue: secondaryRoleValue,
                                onChanged: (val) =>
                                    setState(() => secondaryRoleValue = val),
                              ),
                              Text("💄  "),
                            ],
                          ),
                          Text(
                            "MakeUp Artist",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //Designer
                    Card(
                      color: Colors.redAccent[100],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "👗",
                                groupValue: secondaryRoleValue,
                                onChanged: (val) =>
                                    setState(() => secondaryRoleValue = val),
                              ),
                              Text("👗  "),
                            ],
                          ),
                          Text(
                            "Designer",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),

                    //None
                    Card(
                      color: Colors.grey[200],
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Radio(
                                value: "",
                                groupValue: secondaryRoleValue,
                                onChanged: (val) =>
                                    setState(() => secondaryRoleValue = val),
                              ),
                              Text("-  "),
                            ],
                          ),
                          Text(
                            "None",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  //Save Changes to Database
                  if (newName?.length != 0) {
                    _databaseService.saveUsername(newName);
                  }
                  if (mainRoleValue?.length != 0) {
                    _databaseService.saveRoles(
                        mainRoleValue, secondaryRoleValue);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
