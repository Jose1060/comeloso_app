// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';

class UserOsoDatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future createDataUser(
      {required String uid, required UserOso userOsoData}) async {
    final docRef = _db.collection("users").doc(uid);
    await docRef
        .set(userOsoData.toMap())
        .onError((error, stackTrace) => print(error));
    print("⬆️ Usuario creado: " + userOsoData.toString());
  }

  Future<UserOso?> getDataUser({required String uid}) async {
    final docRef = _db.collection("users").doc(uid);
    await docRef.get().then((doc) {
      if (doc.exists) {
        final data = UserOso.fromDocumentSnapshot(doc);
        print("➡️ Usuario obtenido");
        return data;
      }
    });
    return null;
  }

  Future pullDataUser(
      {required String uid, required UserOso userOsoData}) async {
    final docRef = _db.collection("users").doc(uid);
    await docRef.update(userOsoData.toMapPull()).then(
        (value) => print("⬇️ Usuario actualizado: " + userOsoData.toString()));
  }

  Future<bool> existUserData({required String uid}) async {
    final docRef = _db.collection("users").doc(uid);
    bool resp = false;
    await docRef.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        resp = true;
      } else if (doc.exists == false) {
        resp = false;
      }
    });
    return resp;
  }

  Future setPreferencesUser(
      {required String uid, required UserOso userOsoData}) async {
    final docRef = _db.collection("users").doc(uid);
    await docRef
        .set(userOsoData.toMap())
        .onError((error, stackTrace) => print(error));
  }
}
