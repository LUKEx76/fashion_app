import 'package:fashion_app/screens/home/search/search_list.dart';
import 'package:flutter/material.dart';

class SearchFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        child: SearchList(),
      ),
    );
  }
}
