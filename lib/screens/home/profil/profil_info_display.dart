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
        height: 100,
        child: Center(
          child: Text("${profil.name}"),
        ),
      );
    } else {
      return Container(
        height: 100,
        child: Text("No Data"),
      );
    }
  }
}
