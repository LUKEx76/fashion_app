import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/screens/home/profil/insta_wrapper.dart';
import 'package:fashion_app/screens/home/profil/profil_info_display.dart';
import 'package:fashion_app/services/database.dart';
import 'package:fashion_app/services/instagram.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Profil profil = Provider.of<Profil>(context);
    return StreamProvider<String>.value(
      value: DatabaseService(user: profil.user).accessToken,
      //Either Log in with insta or Display Profil
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ProfilInfoDisplay(),
          InstaWrapper(),
        ],
      ),
    );
  }
}
