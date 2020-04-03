import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/user.dart';

class Profile {
  User user;
  String name;
  String myIgUserId;
  IgAccessToken accessToken;
  String profilePicture;

  Profile({this.user});

  Profile.withData(
      {this.user,
      this.name,
      this.myIgUserId,
      this.accessToken,
      this.profilePicture});

  Profile.fromDatabase(
      {this.user, this.name, this.profilePicture, this.accessToken});
}
