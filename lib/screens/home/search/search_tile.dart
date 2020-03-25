import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/screens/home/search/display_profil.dart';
import 'package:flutter/material.dart';

class SearchTile extends StatelessWidget {
  final Profil profil;

  SearchTile({this.profil});

  @override
  Widget build(BuildContext context) {
    if (profil.profilPicture.length == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayProfil(
                  profil: profil,
                ),
              ),
            ),
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(profil.name),
              subtitle: Text("//ROLE"),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayProfil(
                  profil: profil,
                ),
              ),
            ),
            child: ListTile(
              leading: Image.network(
                profil.profilPicture ?? "",
              ),
              title: Text(profil.name),
              subtitle: Text("//ROLE"),
            ),
          ),
        ),
      );
    }
  }
}
