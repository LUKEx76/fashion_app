import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profil.dart';
import 'package:fashion_app/models/user.dart';

class DatabaseService {
  final CollectionReference profilsCollection =
      Firestore.instance.collection("profils");

  final CollectionReference postsCollection =
      Firestore.instance.collection("posts");

  final User user;
  DatabaseService({this.user});

  //Dummy Data right now
  Future updateUserData(String name, int coolness) async {
    //on the first call, firebase creates document for uid
    return await profilsCollection.document(user.uid).setData({
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
    return Profil(
        user: user,
        name: snapshot.data["name"],
        coolness: snapshot.data["coolness"]);
  }

  //Get User Doc Stream -> Profil Page needs to subscribe to this
  Stream<Profil> get profil {
    return profilsCollection
        .document(user.uid)
        .snapshots()
        .map(_profilFromSnapshot);
  }
}
