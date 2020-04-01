import 'package:fashion_app/models/igMedia.dart';
import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/services/instagram.dart';
import 'package:flutter/material.dart';

class InstaPictureDisplay extends StatefulWidget {
  final Profil profil;

  InstaPictureDisplay({this.profil});

  @override
  _InstaPictureDisplayState createState() => _InstaPictureDisplayState();
}

class _InstaPictureDisplayState extends State<InstaPictureDisplay> {
  InstagramConnector _insta = InstagramConnector();
  List<IgMedia> igMedia;

  @override
  void initState() {
    super.initState();
    waitForPictures();
  }

  void waitForPictures() async {
    List<IgMedia> temp = List<IgMedia>();
    await _insta.allPhotosOfUser(widget.profil).then((list) => temp = list);
    setState(() => igMedia = temp);
  }

  @override
  Widget build(BuildContext context) {
    if (igMedia == null) {
      return Container(
        child: Column(
          children: <Widget>[
            Text("Loading..."),
            SizedBox(height: 20), //Can be deleted
          ],
        ),
      );
    } else {
      return Container(
        child: Flexible(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: igMedia.length ?? 0,
            itemBuilder: (context, index) {
              if (igMedia[index].mediaType == "VIDEO") {
                return Container();
              } else {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Image.network(
                    igMedia[index].mediaUrl,
                  ),
                );
              }
            },
          ),
        ),
      );
    }
  }
}
