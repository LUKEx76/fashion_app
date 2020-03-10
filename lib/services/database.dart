import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';
import 'package:get_it/get_it.dart';

class DatabaseService {
  final CollectionReference profilsCollection =
      Firestore.instance.collection("profils");

  final CollectionReference postsCollection =
      Firestore.instance.collection("posts");

  User user;
  GetIt getIt = GetIt.instance;

  DatabaseService.inital(User user) {
    this.user = user;
    try {
      getIt.get<User>();
    } catch (e) {
      getIt.registerSingleton<User>(user);
    }
  }

  DatabaseService() {
    user = getIt.get<User>();
    if (user == null) {
      print("ERROR: DATABASE INSTANCE WITH A NULL USER");
    }
  }

  //Dummy Data right now
  Future initializeUserData(String name, int coolness) async {
    //on the first call, firebase creates document for uid
    return await profilsCollection.document(name).setData({
      "name": name,
      "coolness": coolness,
    });
  }

  //Get a List of Posts from Snapshot
  List<Post> _postListSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Post(
          name: doc.data["name"] ?? "",
          location: doc.data["location"] ?? "Somewhere",
          time: doc.data["time"] ?? 0);
    }).toList();
  }

  //Setup Dummy Stream
  Stream<List<Post>> get posts {
    return postsCollection.snapshots().map(_postListSnapshot);
  }

  //User Data from Snapshot
  Profil _profilFromSnapshot(DocumentSnapshot snapshot) {
    Profil profil = Profil(user: user);
    profil.name = snapshot.data["name"];
    profil.coolness = snapshot.data["coolness"];
    return profil;
  }

  //Get User Doc Stream -> Profil Page needs to subscribe to this
  Stream<Profil> get profil {
    return profilsCollection
        .document(user.uid)
        .snapshots()
        .map(_profilFromSnapshot);
  }

  //Save AccessToken to Database
  Future saveIgCredentials(String igUserId, String igAccessToken) async {
    return await profilsCollection.document(user.uid).updateData({
      "igUserId": igUserId,
      "igAccessToken": igAccessToken,
    });
  }

  //Might check if expired
  Stream<IgAccessToken> get accessToken {
    return profilsCollection
        .document(user.uid)
        .snapshots()
        .map(_accessTokenFromSnapshot);
  }

  //User Data from Snapshot
  IgAccessToken _accessTokenFromSnapshot(DocumentSnapshot snapshot) {
    return IgAccessToken(
        igUserId: snapshot.data["igUserId"] ?? "",
        igAccessToken: snapshot.data["igAccessToken"] ?? "");
  }

  Future<IgAccessToken> get token {
    //return profilsCollection.document(user.uid).snapshots().
  }
}
