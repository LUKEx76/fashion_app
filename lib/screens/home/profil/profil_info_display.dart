import 'package:fashion_app/models/profil.dart';
import 'package:flutter/material.dart';

class ProfilInfoDisplay extends StatelessWidget {
  final Profil profil;

  ProfilInfoDisplay({this.profil});

  @override
  Widget build(BuildContext context) {
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
