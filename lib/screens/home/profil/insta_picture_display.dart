import 'package:fashion_app/services/instagram.dart';
import 'package:flutter/material.dart';

class InstaPictureDisplay extends StatefulWidget {
  @override
  _InstaPictureDisplayState createState() => _InstaPictureDisplayState();
}

class _InstaPictureDisplayState extends State<InstaPictureDisplay> {
  InstagramConnector _insta = InstagramConnector();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Insta Picture Display"),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
