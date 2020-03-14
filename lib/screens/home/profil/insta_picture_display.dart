import 'package:fashion_app/services/instagram.dart';
import 'package:flutter/material.dart';

class InstaPictureDisplay extends StatefulWidget {
  @override
  _InstaPictureDisplayState createState() => _InstaPictureDisplayState();
}

class _InstaPictureDisplayState extends State<InstaPictureDisplay> {
  InstagramConnector _insta = InstagramConnector();
  List<String> allMediaUrls;

  @override
  void initState() {
    super.initState();
    waitForPictures();
  }

  void waitForPictures() async {
    List<String> mediaUrl;
    await _insta.allPhotosOfUser().then((list) => mediaUrl = list);
    setState(() => allMediaUrls = mediaUrl);
  }

  @override
  Widget build(BuildContext context) {
    if (allMediaUrls == null) {
      return Container(
        child: Column(
          children: <Widget>[
            Text("Loading..."),
            SizedBox(height: 20),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Text("Pictures:"),
            SizedBox(height: 20),
          ],
        ),
      );
    }
  }
}
