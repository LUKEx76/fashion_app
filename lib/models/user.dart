class User {
  final String uid;

  User({this.uid});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["id"],
    );
  }
}
