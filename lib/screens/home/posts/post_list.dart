import 'package:fashion_app/screens/home/posts/post_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/post.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final posts = Provider.of<List<Post>>(context) ?? [];

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostTile(post: posts[index]);
      },
    );
  }
}
