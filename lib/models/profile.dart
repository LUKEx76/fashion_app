import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/user.dart';

class Profile {
  User user;
  String name;
  IgAccessToken accessToken;
  String profilePicture;
  String mainRole;
  String secondaryRole;

  Profile({this.user});

  Profile.fromDatabase(
      {this.user,
      this.name,
      this.profilePicture,
      this.accessToken,
      this.mainRole,
      this.secondaryRole});
}
