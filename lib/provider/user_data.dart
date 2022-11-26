// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UserOso? _currentUser = null;

  UserOso? get currentUser => _currentUser;

  Future getDataUser({required String uid}) async {
    // DocumentSnapshot<Map<String, dynamic>> snapshot =
    //     await dbFire.collection("users").doc(uid).get();

    // if (snapshot.exists) {}

    final docRef = _db.collection("users").doc(uid);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return data;
      } else if (doc.exists == false) {
        print("Not found user ❌");
      }
    });
  }

  Future streamDataUser({required String uid}) async {
    final docRef = _db.collection("users").doc(uid).snapshots();
    return docRef;
  }
}
