import 'package:fashion_app/models/user.dart';

class Profil {
  User user;
  String name;
  String myIgUserId;
  String myIgAccessToken;
  String profilPicture;

  Profil({this.user});

  Profil.withData(
      {this.user,
      this.name,
      this.myIgUserId,
      this.myIgAccessToken,
      this.profilPicture});

  Profil.forDisplay({this.user, this.name, this.profilPicture});

  factory Profil.fromJson(Map<String, dynamic> json) {
    return Profil.forDisplay(
      user: json['user'],
      name: json['name'],
      profilPicture: json['profilPicture'] ?? "",
    );
  }
}
