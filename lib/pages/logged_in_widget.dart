import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/pages/preference_page.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/provider/user_data.dart';
import 'package:comeloso_app/services/user_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoggedInWidget extends StatefulWidget {
  const LoggedInWidget({super.key});

  @override
  State<LoggedInWidget> createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    return ValueListenableBuilder(
      valueListenable: provider.userStatus,
      builder: (BuildContext context, AuthStatus? value, Widget? child) {
        switch (provider.userStatus.value) {
          case AuthStatus.withData:
            return LogWhitData();
          case AuthStatus.withOutData:
            return const PreferenceRegisterPage();
          case AuthStatus.loading:
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  Text("Oli"),
                ],
              ),
            );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text("Oli"),
            ],
          ),
        );
      },
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LogWhitData extends StatelessWidget {
  const LogWhitData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final UserOso? user = provider.userOso;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Logged In"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              provider.logout();
            },
            child: const Text("Logout"),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Profile",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 32,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user!.fotoAvatar!),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Name: ${user.nombre}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Email: ${user.email!}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Email: ${user.email}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
