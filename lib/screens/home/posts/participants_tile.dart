import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/screens/home/profil/insta_picture_display.dart';
import 'package:flutter/material.dart';

class ParticipantsTile extends StatelessWidget {
  final Profil participant;

  ParticipantsTile({this.participant});

  @override
  Widget build(BuildContext context) {
    if (participant == null) {
      return Container();
    } else {
      if (participant.profilPicture.length == 0) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            elevation: 10.0,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InstaPictureDisplay(profil: participant),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50.0,
                ),
                title: Text(participant.name),
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
                  builder: (context) =>
                      InstaPictureDisplay(profil: participant),
                ),
              ),
              child: ListTile(
                leading: Image.network(
                  participant.profilPicture ?? "",
                ),
                title: Text(participant.name),
              ),
            ),
          ),
        );
      }
    }
  }
}
