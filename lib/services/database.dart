import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference testCollection =
      Firestore.instance.collection("test");
}
