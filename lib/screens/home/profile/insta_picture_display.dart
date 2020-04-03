import 'package:fashion_app/models/igMedia.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/services/instagram.dart';
import 'package:flutter/material.dart';

class InstaPictureDisplay extends StatefulWidget {
  final Profile profile;

  InstaPictureDisplay({this.profile});

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
    await _insta.allPhotosOfUser(widget.profile).then((list) => temp = list);
    if (mounted) {
      //check if widget still is displayed
      setState(() => igMedia = temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (igMedia == null) {
      return Container(
        child: Center(
          child: Text("Loading..."),
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
