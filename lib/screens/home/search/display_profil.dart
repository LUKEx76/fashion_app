import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/screens/home/profil/insta_picture_display.dart';
import 'package:fashion_app/screens/home/profil/profil_info_display.dart';
import 'package:flutter/material.dart';

class DisplayProfil extends StatelessWidget {
  final Profil profil;

  DisplayProfil({this.profil});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Details"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ProfilInfoDisplay(profil: profil),
          InstaPictureDisplay(profil: profil),
        ],
      ),
    );
  }
}
