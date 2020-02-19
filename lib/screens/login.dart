import 'package:flutter/material.dart';

//REDUNDANT, AS AUTHENTICATE SHOULD DO ITS WORK
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fashion app"),
      ),
      body: Text("Login Page"),
    );
  }
}
