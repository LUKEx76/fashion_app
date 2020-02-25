import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/screens/home/profil/profil_display.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<Profil>.value(
      value: DatabaseService(user: user).profil,
      child: ProfilDisplay(),
      /*builder: (context, snapshot) {
          if (snapshot.hasData) {
            User user = snapshot.data;
            return Container(
              child: Text(
                  "Name: ${user.name} // Sugars: ${user.sugars} // Strength: ${user.strength}"),
            );
          } else {
            return Container(
              child: Text("No Data"),
            );
          }
        }*/
    );
  }
}
