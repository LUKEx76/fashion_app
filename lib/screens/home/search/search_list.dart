import 'package:fashion_app/screens/home/search/search_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/profil.dart';

class SearchList extends StatefulWidget {
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    final profils = Provider.of<List<Profil>>(context) ?? [];

    return ListView.builder(
      itemCount: profils.length,
      itemBuilder: (context, index) {
        return SearchTile(profil: profils[index]);
      },
    );
  }
}
