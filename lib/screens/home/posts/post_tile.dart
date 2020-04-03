import 'package:fashion_app/models/profile.dart';
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
  Profile creatorProfile;

  @override
  void initState() {
    super.initState();
    waitForCreatorProfile();
  }

  void waitForCreatorProfile() async {
    Profile temp = await _databaseService.getProfile(widget.post.creator);
    if (mounted) {
      //Check if widget still is displayed
      setState(() => creatorProfile = temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    waitForCreatorProfile();
    if (creatorProfile == null) {
      return Container();
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 10.0,
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPost(
                  post: widget.post,
                  creatorProfile: creatorProfile,
                ),
              ),
            ),
            child: ListTile(
              leading: creatorProfile.profilePicture.length == 0
                  ? Icon(
                      Icons.person,
                      size: 50.0,
                    )
                  : Image.network(
                      creatorProfile.profilePicture ?? "",
                    ),
              title: Text(widget.post.name),
              subtitle: Text("in ${widget.post.location}"),
              trailing: Text(
                "${widget.post.date.day} | ${widget.post.date.month} | ${widget.post.date.year}",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      );
    }
  }
}
