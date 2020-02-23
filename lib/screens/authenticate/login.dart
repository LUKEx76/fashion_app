import 'package:fashion_app/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();

  //Text field state
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 50.0,
        ),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Log In"),
                onPressed: () async {
                  print(email + " - " + password);
                  _auth.signInAnonym();
                },
              ),
              SizedBox(height: 50.0),
              Text(
                "You don't have an account yet?",
                textAlign: TextAlign.center,
              ),
              FlatButton(
                child: Text(
                  "Register now!",
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
