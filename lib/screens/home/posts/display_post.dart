import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profil.dart';
import 'package:flutter/material.dart';

class DisplayPost extends StatefulWidget {
  final Post post;
  final Profil creatorProfil;

  DisplayPost({this.post, this.creatorProfil});

  @override
  _DisplayPostState createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: Container(),
    );
  }
}
