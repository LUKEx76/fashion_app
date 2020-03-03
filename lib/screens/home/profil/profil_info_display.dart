import 'package:fashion_app/models/profil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilInfoDisplay extends StatefulWidget {
  @override
  _ProfilInfoDisplayState createState() => _ProfilInfoDisplayState();
}

class _ProfilInfoDisplayState extends State<ProfilInfoDisplay> {
  @override
  Widget build(BuildContext context) {
    final profil = Provider.of<Profil>(context);
    if (profil != null) {
      return Container(
        child: Center(
          child: Text(
              "Name: ${profil.name} // Coolness: ${profil.coolness} // uid: ${profil.user.uid}"),
        ),
      );
    } else {
      return Container(
        child: Text("No Data"),
      );
    }
  }
}
