import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/profile/associated_posts.dart';
import 'package:fashion_app/screens/home/profile/insta_wrapper.dart';
import 'package:fashion_app/screens/home/profile/profile_info_display.dart';
import 'package:fashion_app/screens/home/profile/role_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Column(
              children: <Widget>[
                ProfileInfoDisplay(profile: profile),
                RoleWrapper(profile: profile),
              ],
            ),
          ),

          //DEFAULT TABCONTROLLER
          //Either Log in with insta or Display Profil

          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                appBar: TabBar(
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    unselectedLabelColor: Colors.black54,
                    tabs: [
                      Tab(text: "Pictures"),
                      Tab(text: "Events"),
                    ]),
                body: TabBarView(children: [
                  InstaWrapper(profile: profile),
                  AssociatedPosts(),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
