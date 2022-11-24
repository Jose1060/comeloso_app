import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserDataProvider extends ChangeNotifier {
  final dbFire = FirebaseFirestore.instance;
  final UserOso? _currentUser = null;

  UserOso? get currentUser => _currentUser;

  Future getDataUser({required String uid}) async {
    // DocumentSnapshot<Map<String, dynamic>> snapshot =
    //     await dbFire.collection("users").doc(uid).get();

    // if (snapshot.exists) {}

    final docRef = dbFire.collection("users").doc(uid);
    docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
        return data;
        //_currentUser = data;
      } else if (doc.exists == false) {
        print("Not found user ❌");
      }
    });
  }

  Future streamDataUser({required String uid}) async {
    final docRef = dbFire.collection("users").doc(uid).snapshots();
    return docRef;
  }
}
