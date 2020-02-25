import 'package:flutter/material.dart';
import 'package:fashion_app/models/post.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 10.0,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(post.name),
          subtitle: Text("in ${post.location} at ${post.time}"),
        ),
      ),
    );
  }
}
