import 'package:fashion_app/screens/home/home.dart';
import 'package:fashion_app/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Login();
    } else {
      return Home();
    }
  }
}
