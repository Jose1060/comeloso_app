import 'package:comeloso_app/pages/login_page.dart';
import 'package:comeloso_app/pages/preference_page.dart';
import 'package:comeloso_app/provider/user_data.dart';
import 'package:comeloso_app/pages/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("🐻" + snapshot.toString());
          if (snapshot.hasData) {
            return const LoggedInWidget();
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Something Went Wrong!"),
            );
          } else if (snapshot.hasData == false) {
            return const LoginPage();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class Home1 extends StatelessWidget {
  const Home1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print("🐻" + snapshot.toString());
        if (snapshot.hasData) {
          return const LoggedInWidget();
        } else if (snapshot.hasError) {
          return const Center(
            child: Text("Something Went Wrong!"),
          );
        } else if (snapshot.hasData == false) {
          return const LoginPage();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
