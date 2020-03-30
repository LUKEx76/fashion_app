import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/screens/home/posts/display_post.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/models/post.dart';

class PostTile extends StatefulWidget {
  final Post post;

  PostTile({this.post});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  final DatabaseService _databaseService = DatabaseService();
  Profil creatorProfil;

  @override
  void initState() {
    super.initState();
    waitForCreatorProfil();
  }

  void waitForCreatorProfil() async {
    Profil temp = await _databaseService.getProfil(widget.post.creator);
    setState(() => creatorProfil = temp);
  }

  @override
  Widget build(BuildContext context) {
    if (creatorProfil == null) {
      return Container();
    } else {
      if (creatorProfil.profilPicture.length == 0) {
        return Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Card(
            elevation: 10.0,
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPost(
                    post: widget.post,
                    creatorProfil: creatorProfil,
                  ),
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50.0,
                ),
                title: Text(widget.post.name),
                subtitle: Text(
                    "in ${widget.post.location} on ${widget.post.date.day} | ${widget.post.date.month} | ${widget.post.date.year}"),
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
                  builder: (context) => DisplayPost(
                    post: widget.post,
                    creatorProfil: creatorProfil,
                  ),
                ),
              ),
              child: ListTile(
                leading: Image.network(
                  creatorProfil.profilPicture ?? "",
                ),
                title: Text(widget.post.name),
                subtitle: Text(
                    "in ${widget.post.location} on ${widget.post.date.day} | ${widget.post.date.month} | ${widget.post.date.year}"),
              ),
            ),
          ),
        );
      }
    }
  }
}
