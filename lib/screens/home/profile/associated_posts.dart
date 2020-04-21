import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/screens/home/posts/post_tile.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';

class AssociatedPosts extends StatefulWidget {
  @override
  _AssociatedPostsState createState() => _AssociatedPostsState();
}

class _AssociatedPostsState extends State<AssociatedPosts> {
  final DatabaseService _databaseService = DatabaseService();
  List<Post> associatedPosts;

  @override
  void initState() {
    associatedPosts = List<Post>();
    waitForDatabase();
    super.initState();
  }

  void waitForDatabase() async {
    List<Post> tmp = await _databaseService.getAssociatedPosts();
    if (mounted) {
      //Check if widget still is displayed
      setState(() => associatedPosts = tmp);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (associatedPosts?.length == 0) {
      return Container(
        child: Center(
          child: Text("No associated Posts found..."),
        ),
      );
    } else {
      return Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: associatedPosts.length ?? 0,
          itemBuilder: (context, index) {
            return PostTile(post: associatedPosts[index]);
          },
        ),
      );
    }
  }
}
