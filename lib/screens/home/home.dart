import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/screens/home/posts/posts_fragment.dart';
import 'package:fashion_app/screens/home/profil/profil_fragment.dart';
import 'package:fashion_app/screens/home/search/search_fragment.dart';
import 'package:fashion_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:fashion_app/models/post.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int currentTab;
  PostsFragment posts;
  SearchFragment search;
  ProfilFragment profil;
  List<Widget> tabs;
  Widget currentPage;

  @override
  void initState() {
    currentTab = 0;
    posts = PostsFragment();
    search = SearchFragment();
    profil = ProfilFragment();

    tabs = [posts, search, profil];
    currentPage = posts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamProvider<Profil>.value(
      value: DatabaseService(user: user).profil,
      child: Scaffold(
        appBar: AppBar(
          title: Text("fashion app"),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.keyboard_arrow_left),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: currentPage,
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (index) {
              setState(() {
                currentTab = index;
                currentPage = tabs[index];
              });
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profil"),
              ),
            ]),
      ),
    );
  }
}
