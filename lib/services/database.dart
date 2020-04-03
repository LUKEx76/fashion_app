import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/models/igAccessToken.dart';
import 'package:fashion_app/models/igMedia.dart';
import 'package:fashion_app/models/post.dart';
import 'package:fashion_app/models/profile.dart';
import 'package:fashion_app/models/user.dart';
import 'package:get_it/get_it.dart';

class DatabaseService {
  //Typo in Profiles Collection: Name "profils" and Field "profilPicture"
  final CollectionReference profilesCollection =
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
  Future initializeUserData(String name) async {
    //on the first call, firebase creates document for uid
    return await profilesCollection.document(name).setData({
      "name": name,
    });
  }

  //Get a List of Posts from Snapshot
  List<Post> _postListSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      Timestamp timestamp = doc.data["date"];
      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
      List<User> participants =
          participantsFromDoc(doc).map((item) => User(uid: item)).toList();
      return Post.fromDatabase(
          creator: User(uid: doc.data["creator"]),
          name: doc.data["name"] ?? "",
          location: doc.data["location"] ?? "Somewhere",
          description: doc.data["description"] ?? "",
          date: date ?? null,
          id: doc.documentID,
          participants: participants);
    }).toList();
  }

  //Setup Dummy Stream
  Stream<List<Post>> get posts {
    return postsCollection.snapshots().map(_postListSnapshot);
  }

  //User Data from Snapshot
  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    Profile profile = Profile(user: User(uid: snapshot.documentID));
    profile.name = snapshot.data["name"];
    return profile;
  }

  //Get User Doc Stream -> Profile Page needs to subscribe to this
  Stream<Profile> get profile {
    return profilesCollection
        .document(user.uid)
        .snapshots()
        .map(_profileFromSnapshot);
  }

  //Save AccessToken to Database
  Future saveIgCredentials(String igUserId, String igAccessToken) async {
    return await profilesCollection.document(user.uid).updateData({
      "igUserId": igUserId,
      "igAccessToken": igAccessToken,
    });
  }

  //Might check if expired
  Stream<IgAccessToken> get accessToken {
    return profilesCollection
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

  //Save Username to Database
  Future saveUsername(String userName) async {
    return await profilesCollection.document(user.uid).updateData({
      "name": userName,
    });
  }

  //Get a List of Profiles from Snapshot
  List<Profile> _profileListSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Profile.fromDatabase(
        user: User(uid: doc.documentID),
        name: doc.data["name"] ?? "",
        profilePicture: doc.data["profilPicture"] ?? "",
        accessToken: IgAccessToken(
            igUserId: doc.data["igUserId"] ?? "",
            igAccessToken: doc.data["igAccessToken"]),
      );
    }).toList();
  }

  Stream<List<Profile>> get profiles {
    return profilesCollection.snapshots().map(_profileListSnapshot);
  }

  //Save Username to Database
  Future saveProfilePicture(IgMedia profilePicture) async {
    return await profilesCollection.document(user.uid).updateData({
      "profilPicture": profilePicture.mediaUrl,
    });
  }

  Future<IgAccessToken> getAccessTokenFromUser(User user) async {
    DocumentSnapshot userDocument =
        await profilesCollection.document(user.uid).get();
    return IgAccessToken(
        igUserId: userDocument.data["igUserId"] ?? "",
        igAccessToken: userDocument.data["igAccessToken"] ?? "");
  }

  //Save Event from Create Event Form
  Future saveEvent(
      String name, String location, String description, DateTime date) async {
    return await postsCollection.add({
      "creator": user.uid,
      "name": name,
      "location": location,
      "description": description,
      "date": date,
    });
  }

  Future<Profile> getProfile(User user) async {
    DocumentSnapshot userDoc =
        await profilesCollection.document(user.uid).get();
    if (userDoc.data == null) {
      return null;
    }
    return Profile.fromDatabase(
      user: user,
      name: userDoc.data["name"] ?? "",
      profilePicture: userDoc.data["profilPicture"] ?? "",
      accessToken: IgAccessToken(
          igUserId: userDoc.data["igUserId"] ?? "",
          igAccessToken: userDoc.data["igAccessToken"]),
    );
  }

  Future<List<Profile>> getParticipants(Post post) async {
    if (post.id == null) {
      return null;
    }
    DocumentSnapshot postDocument =
        await postsCollection.document(post.id).get();
    if (postDocument.data == null) {
      return null;
    }

    DocumentSnapshot postDoc = await postsCollection.document(post.id).get();

    if (postDoc.data["participants"] == null) {
      return null;
    }
    List<String> partUsers = participantsFromDoc(postDoc);

    if (partUsers.length == 0) {
      return null;
    }

    List<Profile> participants = List<Profile>();
    for (String part in partUsers) {
      DocumentSnapshot partDoc = await profilesCollection.document(part).get();
      if (partDoc.data == null) {
        return null;
      }
      participants.add(Profile.fromDatabase(
        user: user,
        name: partDoc.data["name"] ?? "",
        profilePicture: partDoc.data["profilPicture"] ?? "",
        accessToken: IgAccessToken(
            igUserId: partDoc.data["igUserId"] ?? "",
            igAccessToken: partDoc.data["igAccessToken"]),
      ));
    }

    return participants;
  }

  Future addSelfAsParticipant(Post post) async {
    if (post.id == null) {
      return;
    }
    DocumentSnapshot postDoc = await postsCollection.document(post.id).get();
    if (postDoc.data["participants"] == null) {
      postsCollection.document(post.id).updateData({"participants": user.uid});
      return;
    }

    List<String> participants = participantsFromDoc(postDoc);

    participants.add(user.uid);
    postsCollection
        .document(post.id)
        .updateData({"participants": participants});
  }

  Future<bool> isSelfAlreadyPart(Post post) async {
    if (post.id == null) {
      return false;
    }
    DocumentSnapshot postDoc = await postsCollection.document(post.id).get();

    List<String> participants = participantsFromDoc(postDoc);

    for (String part in participants) {
      if (part == user.uid) {
        return true;
      }
    }
    return false;
  }

  //HELPER FUNCTIONS
  List<String> participantsFromDoc(DocumentSnapshot doc) {
    List<String> participants;
    if (doc.data["participants"] == null) {
      participants = List<String>();
      return participants;
    }
    if (doc.data["participants"].runtimeType == String) {
      participants = List<String>();
      participants.add(doc.data["participants"]);
    } else {
      participants = List.from(doc.data["participants"]);
    }
    return participants;
  }

  Future<Post> getPost(Post post) async {
    if (post.id == null) {
      return null;
    }
    DocumentSnapshot postDoc = await postsCollection.document(post.id).get();
    if (postDoc.data == null) {
      return null;
    }

    Timestamp timestamp = postDoc.data["date"];
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    List<User> participants =
        participantsFromDoc(postDoc).map((item) => User(uid: item)).toList();
    return Post.fromDatabase(
        creator: User(uid: postDoc.data["creator"]),
        name: postDoc.data["name"] ?? "",
        location: postDoc.data["location"] ?? "Somewhere",
        description: postDoc.data["description"] ?? "",
        date: date ?? null,
        id: postDoc.documentID,
        participants: participants);
  }
}
