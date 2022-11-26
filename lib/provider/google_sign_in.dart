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
  unauthenticated
}

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  UserOso? _userOso;
  GoogleSignInAccount get user => _user!;
  var userOsoDatabaseService = UserOsoDatabaseService();

  Future googleLogin() async {
    notifyListeners();
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
          _userOso =
              await userOsoDatabaseService.getDataUser(uid: value.user!.uid);
        } else {
          final UserOso currentUser = UserOso(
            email: value.user!.email,
            fotoAvatar: value.user!.photoURL,
            nombre: value.user!.displayName,
          );
          userOsoDatabaseService.pullDataUser(
              uid: value.user!.uid, userOsoData: currentUser);
          _userOso =
              await userOsoDatabaseService.getDataUser(uid: value.user!.uid);
          print("🍅 -----> " + _user.toString());
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
}
