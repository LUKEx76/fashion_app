import 'package:fashion_app/models/user.dart';
import 'package:fashion_app/services/database.dart';

class Profil {
  final User user;
  String name;
  int coolness;
  String myIgUserId;
  String myIgAccessToken;

  Profil({this.user});

  Profil.withData(
      {this.user,
      this.name,
      this.coolness,
      this.myIgUserId,
      this.myIgAccessToken});
}
