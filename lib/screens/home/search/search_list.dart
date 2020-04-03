import 'package:fashion_app/screens/home/search/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/profile.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final profiles = Provider.of<List<Profile>>(context) ?? [];

    return ListView.builder(
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        return ProfileTile(profile: profiles[index]);
      },
    );
  }
}
