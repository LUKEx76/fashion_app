import 'package:fashion_app/services/auth.dart';
import 'package:fashion_app/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/shared/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

//VALIDATION MUST CHECK IF THERE IS A " " behind the email
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Text field state
  String email = "";
  String password = "";
  String errorMsg = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Register"),
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
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (value) =>
                          value.isEmpty ? 'Enter an email' : null,
                      onChanged: (value) {
                        setState(() => email = value);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
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
                      child: Text("Register"),
                      onPressed: () async {
                        //Register User
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              errorMsg = "Provide a valide email";
                            });
                          }
                          setState(() => loading = false);
                          Navigator.pop(context);
                          //Auth Stream brings User to HomePage
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      errorMsg,
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
