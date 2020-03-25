import 'package:fashion_app/screens/home/posts/post_list.dart';
import 'package:flutter/material.dart';

class PostsFragment extends StatefulWidget {
  @override
  _PostsFragmentState createState() => _PostsFragmentState();
}

class _PostsFragmentState extends State<PostsFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PostList(),
    );
  }
}
