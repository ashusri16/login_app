import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListItems {
  static CollectionReference get listCollection =>
      FirebaseFirestore.instance.collection('listItems');

  static Future<List<QueryDocumentSnapshot>> list() async {
    final QuerySnapshot result = await listCollection.get();
    return result.docs;
  }
}
