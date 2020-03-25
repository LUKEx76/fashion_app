import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/screens/home/profil/insta_wrapper.dart';
import 'package:fashion_app/screens/home/profil/profil_info_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profil = Provider.of<Profil>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ProfilInfoDisplay(profil: profil),
        //Either Log in with insta or Display Profil
        InstaWrapper(profil: profil),
      ],
    );
  }
}
