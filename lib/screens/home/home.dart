import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/screens/home/posts/posts_fragment.dart';
import 'package:fashion_app/screens/home/profil/profil_fragment.dart';
import 'package:fashion_app/screens/home/search/search_fragment.dart';
import 'package:fashion_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fashion_app/services/database.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  GetIt getIt;
  bool showFab;
  int currentTab;
  PostsFragment posts;
  SearchFragment search;
  ProfilFragment profil;
  List<Widget> tabs;
  Widget currentPage;

  @override
  void initState() {
    getIt = GetIt.instance;
    showFab = true;
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
    return MultiProvider(
      providers: [
        StreamProvider<Profil>.value(
          value: DatabaseService.inital(user).profil,
        ),
        StreamProvider<List<Profil>>.value(
          value: DatabaseService.inital(user).profils,
        ),
        StreamProvider<List<Post>>.value(
          value: DatabaseService().posts,
        ),
        StreamProvider<IgAccessToken>.value(
          value: DatabaseService().accessToken,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("fashion app"),
          actions: <Widget>[
            FlatButton(
              child: Icon(Icons.keyboard_arrow_left),
              onPressed: () async {
                try {
                  getIt.reset();
                } catch (e) {
                  print("ERROR GetIt: " + e.toString());
                }
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: currentPage,
        floatingActionButton: Opacity(
          opacity: showFab ? 1 : 0,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => print("FAB BUTTON PRESSED"), //Create Event
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTab,
            onTap: (index) {
              setState(() {
                if (index == 0) {
                  showFab = true;
                } else {
                  showFab = false;
                }
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
