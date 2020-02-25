import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/screens/home/posts/post_list.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostsFragment extends StatefulWidget {
  @override
  _PostsFragmentState createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService().posts,
      child: PostList(),
    );
  }
}
