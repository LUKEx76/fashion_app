import 'package:fashion_app/screens/wrapper.dart';
import 'package:fashion_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // ROOT WIDGET
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
