import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/services/database.dart';
import 'package:fashion_app/shared/constants.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKey = GlobalKey<FormState>();
  final DatabaseService _databaseService = DatabaseService();

  String eventName;
  String eventLocation;
  String eventDescription;
  DateTime eventDate;

  @override
  void initState() {
    super.initState();
    eventName = "";
    eventLocation = "";
    eventDescription = "";
    eventDate = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                "Create an Event:",
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 30.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Name"),
                validator: (value) =>
                    value.isEmpty ? 'Enter a name for your event' : null,
                onChanged: (value) {
                  setState(() => eventName = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Location"),
                validator: (value) =>
                    value.isEmpty ? 'Enter a location for your event' : null,
                onChanged: (value) {
                  setState(() => eventLocation = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: "Description"),
                validator: (value) =>
                    value.isEmpty ? 'Enter a description for your event' : null,
                onChanged: (value) {
                  setState(() => eventDescription = value);
                },
              ),
              SizedBox(height: 30.0),
              Text(
                eventDate == null
                    ? "No Date picked yet"
                    : "Date: " +
                        eventDate.day.toString() +
                        "." +
                        eventDate.month.toString() +
                        "." +
                        eventDate.year.toString(),
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              FlatButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2024),
                  ).then((date) {
                    setState(() {
                      eventDate = date;
                    });
                  });
                },
                child: Text(
                  "Pick a Date",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Create Event"),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    if (eventDate != null &&
                        eventDate.isAfter(DateTime.now())) {
                      _databaseService.saveEvent(eventName, eventLocation,
                          eventDescription, eventDate);
                      Navigator.pop(context);
                    } else {
                      //Give Feedback if Date is
                      print("Date is not valide: " + eventDate.toString());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
