import 'package:fashion_app/models/user.dart';

class Post {
  final User creator;
  final String name;
  final String location;
  final String description;
  final DateTime date;
  String id;
  List<User> participants;

  Post({this.creator, this.name, this.location, this.description, this.date});

  Post.fromDatabase(
      {this.creator,
      this.name,
      this.location,
      this.description,
      this.date,
      this.id,
      this.participants});

  /*factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      creator: json['creator'] ?? "",
      name: json['name'] ?? "",
      location: json['location'] ?? "",
      description: json['description'] ?? "",
      date: json['date'],
    );
  }*/
}
