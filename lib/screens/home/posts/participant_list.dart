import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/screens/home/search/profile_tile.dart';
import 'package:fashion_app/services/database.dart';
import 'package:flutter/material.dart';

class ParticipantList extends StatefulWidget {
  final Post post;

  ParticipantList({this.post});
  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  DatabaseService _databaseService = DatabaseService();
  List<Profile> participants;

  @override
  void initState() {
    super.initState();
    waitForParticipants();
  }

  void waitForParticipants() async {
    List<Profile> temp = await _databaseService.getParticipants(widget.post);
    if (mounted) {
      //check if widget still is displayed
      setState(() => participants = temp);
    }
  }

  @override
  Widget build(BuildContext context) {
    waitForParticipants();
    if (participants == null) {
      return Container();
    } else if (participants.length == 0) {
      return Container();
    } else {
      return Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: participants.length,
          itemBuilder: (context, index) {
            return ProfileTile(profile: participants[index]);
          },
        ),
      );
    }
  }
}
