import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/screens/home/posts/post_create.dart';
import 'package:fashion_app/screens/home/posts/posts_fragment.dart';
import 'package:fashion_app/screens/home/profile/profile_fragment.dart';
import 'package:fashion_app/screens/home/search/search_fragment.dart';
import 'package:fashion_app/screens/home/settings.dart';
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
  final List<String> dropDownValues = ["Settings", "Logout"];

  GetIt getIt;
  bool showFab;
  int currentTab;
  PostsFragment posts;
  SearchFragment search;
  ProfileFragment profile;
  List<Widget> tabs;
  Widget currentPage;

  @override
  void initState() {
    getIt = GetIt.instance;
    showFab = true;
    currentTab = 0;
    posts = PostsFragment();
    search = SearchFragment();
    profile = ProfileFragment();

    tabs = [posts, search, profile];
    currentPage = posts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MultiProvider(
      providers: [
        StreamProvider<Profile>.value(
          value: DatabaseService.inital(user).profile,
        ),
        StreamProvider<List<Profile>>.value(
          value: DatabaseService.inital(user).profiles,
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
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: DropdownButton(
                icon: Icon(Icons.more_vert),
                items: dropDownValues
                    .map((f) => DropdownMenuItem(
                          child: Text(f),
                          value: f,
                        ))
                    .toList(),
                onChanged: (value) async {
                  print(value);
                  switch (value) {
                    case "Settings":
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Settings()));
                      break;

                    case "Logout":
                      try {
                        getIt.reset();
                      } catch (e) {
                        print("ERROR GetIt: " + e.toString());
                      }
                      await _auth.signOut();
                      break;

                    default:
                      print(value + " is not a valid Dropdown Menu item");
                      break;
                  }
                },
              ),
            ),
          ],
        ),
        body: currentPage,
        floatingActionButton: Opacity(
          opacity: showFab ? 1 : 0,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreatePost())),
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
                title: Text("Profile"),
              ),
            ]),
      ),
    );
  }
}
