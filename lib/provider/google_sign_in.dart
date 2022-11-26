import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/provider/user_data.dart';
import 'package:comeloso_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  uninitialized,
  authenticated,
  authenticating,
  unauthenticated,
  loading,
  withData,
  withOutData
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  UserOso? _userOso = null;
  GoogleSignInAccount get user => _user!;
  var userOsoDatabaseService = UserOsoDatabaseService();
  final ValueNotifier<AuthStatus?> _userStatus =
      ValueNotifier<AuthStatus>(AuthStatus.uninitialized);

  Future googleLogin() async {
    notifyListeners();
    notifyUserData(status: AuthStatus.loading);
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        if (await userOsoDatabaseService.existUserData(uid: value.user!.uid) ==
            false) {
          final UserOso currentUser = UserOso(
            activo: false,
            terminos: false,
            email: value.user!.email,
            fotoAvatar: value.user!.photoURL,
            nombre: value.user!.displayName,
          );
          userOsoDatabaseService
              .createDataUser(uid: value.user!.uid, userOsoData: currentUser)
              .then((value) => _userOso = userOsoDatabaseService.getDataUser(
                  uid: _user!.id) as UserOso?);
          _userOso = await userOsoDatabaseService
              .getDataUser(uid: value.user!.uid)
              .whenComplete(() => notifyUserData(status: AuthStatus.withData));
        } else {
          final UserOso currentUser = UserOso(
            email: value.user!.email,
            fotoAvatar: value.user!.photoURL,
            nombre: value.user!.displayName,
          );
          userOsoDatabaseService.pullDataUser(
              uid: value.user!.uid, userOsoData: currentUser);
          _userOso = await userOsoDatabaseService
              .getDataUser(uid: value.user!.uid)
              .whenComplete(() => notifyUserData(status: AuthStatus.withData));
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    _user = null;
  }

  Future updateUser({required String userUID}) async {
    UserOso? data =
        await userOsoDatabaseService.getDataUser(uid: userUID).whenComplete(() {
      notifyUserData(status: AuthStatus.withData);
    });
    _userOso = data;
    notifyListeners();
  }

  UserOso? get userOso => _userOso;
  ValueNotifier<AuthStatus?> get userStatus => _userStatus;

  Future notifyUserData({required AuthStatus status}) async {
    print("🐼 verificando status  ->" + status.toString());
    print("🐼 verificando data  ->" + _userOso.toString());
    _userStatus.value = status;
  }
}
