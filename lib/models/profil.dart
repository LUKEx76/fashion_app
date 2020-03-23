import 'package:fashion_app/models/igMedia.dart';
import 'package:fashion_app/models/user.dart';

class Profil {
  User user;
  String name;
  int coolness;
  String myIgUserId;
  String myIgAccessToken;
  String profilPicture;

  Profil({this.user});

  Profil.withData(
      {this.user,
      this.name,
      this.coolness,
      this.myIgUserId,
      this.myIgAccessToken,
      this.profilPicture});

  Profil.forDisplay({this.name, this.profilPicture});
}
