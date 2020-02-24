import 'package:fashion_app/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/services/auth.dart';
import 'package:fashion_app/shared/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = "";
  String password = "";
  String errorMsg = "";

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
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (value) => value.isEmpty ? 'Enter an email' : null,
                onChanged: (value) {
                  setState(() => email = value);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (value) => value.length < 6
                    ? 'Enter a password with 6 chars or more'
                    : null,
                obscureText: true,
                onChanged: (value) {
                  setState(() => password = value);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text("Log In"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.loginWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() => errorMsg =
                          "Could not log in with the given credentials");
                    }
                    //Auth Stream brings User to HomePage
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                errorMsg,
                style: TextStyle(color: Colors.red),
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
