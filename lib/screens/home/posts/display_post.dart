import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/posts/participant_list.dart';
import 'package:fashion_app/screens/home/search/profile_tile.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';

class DisplayPost extends StatefulWidget {
  final Post post;
  final Profile creatorProfile;

  DisplayPost({this.post, this.creatorProfile});

  @override
  _DisplayPostState createState() => _DisplayPostState();
}

class _DisplayPostState extends State<DisplayPost> {
  DatabaseService _databaseService = DatabaseService();
  Post currentPost;
  bool alreadyPart;

  @override
  void initState() {
    currentPost = widget.post;
    alreadyPart = false;
    waitForDatabase();
    super.initState();
  }

  void waitForDatabase() async {
    Post tempPost = await _databaseService.getPost(widget.post);
    bool tempBool = await _databaseService.isSelfAlreadyPart(widget.post);
    if (mounted) {
      //Check if widget still is displayed
      setState(() {
        alreadyPart = tempBool;
        currentPost = tempPost;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Details"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              currentPost.name,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 120.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.location_on),
                  Text(
                    widget.post.location,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 120.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.date_range),
                  Text(
                    "${widget.post.date.day} | ${widget.post.date.month} | ${widget.post.date.year}",
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              widget.post.description,
              style: TextStyle(fontSize: 14.0),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 30.0),
            Text("CREATOR:"),
            ProfileTile(profile: widget.creatorProfile),
            SizedBox(height: 40.0),
            Text("PARTICIPANTS:"),
            ParticipantList(post: currentPost),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text("Request to Participate"),
              onPressed:
                  widget.creatorProfile.user.uid == _databaseService.user.uid ||
                          alreadyPart
                      ? null
                      : () {
                          _databaseService.addSelfAsParticipant(widget.post);
                          waitForDatabase();
                        },
            ),
          ],
        ),
      ),
    );
  }
}
