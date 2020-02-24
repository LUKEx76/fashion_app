import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/models/user.dart';

//MIGHT DO THIS AS A SINGLETON
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create User object from Firebase Response
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      return User(uid: user.uid);
    } else {
      return null;
    }
  }

  //Auth Stream changes
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //Sign in Anonymously
  Future signInAnonym() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = _userFromFirebaseUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Log in with Email and Password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = _userFromFirebaseUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
