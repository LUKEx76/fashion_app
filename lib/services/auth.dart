import 'package:fashion_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashion_app/models/user.dart';
import 'package:get_it/get_it.dart';

//MIGHT DO THIS AS A SINGLETON
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GetIt getIt = GetIt.instance;

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
          email: email.trim(), password: password.trim());
      User user = _userFromFirebaseUser(result.user);
      //Create document for new User
      await DatabaseService.inital(user).initializeUserData(user.uid);
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
          email: email.trim(), password: password.trim());
      User user = _userFromFirebaseUser(result.user);
      DatabaseService.inital(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
