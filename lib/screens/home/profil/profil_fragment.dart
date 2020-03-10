import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/screens/home/profil/insta_wrapper.dart';
import 'package:fashion_app/screens/home/profil/profil_info_display.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<IgAccessToken>.value(
      value: DatabaseService().accessToken,
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
