import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comeloso_app/models/user.dart';
import 'package:comeloso_app/screen/preference_page.dart';
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
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final userLogged = FirebaseAuth.instance.currentUser!;
    final update = provider.updateUser(userUID: userLogged.uid);

    return FutureBuilder(
        future: update,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            ValueListenableBuilder(
              valueListenable: provider.userStatus,
              builder:
                  (BuildContext context, AuthStatus? value, Widget? child) {
                switch (provider.userStatus.value) {
                  case AuthStatus.withData:
                    return const LogWhitData();
                  case AuthStatus.withOutDataPreferences:
                    return const PreferenceRegisterPage();
                  case AuthStatus.loading:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text("Oli 3"),
                        ],
                      ),
                    );
                  default:
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          CircularProgressIndicator(),
                          Text("Oli 2"),
                        ],
                      ),
                    );
                }
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                ),
              ],
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text("Oli assss"),
              ],
            ),
          );
        });
  }
}

class LogWhitData extends StatelessWidget {
  const LogWhitData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final userLogged = FirebaseAuth.instance.currentUser!;
    final update = provider.updateUser(userUID: userLogged.uid);

    update.then((value) {});

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
      body: FutureBuilder(
          future: update,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              return LogTest();
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    Text("Oli a"),
                  ],
                ),
              );
            }
          }),
    );
  }
}

class LogTest extends StatelessWidget {
  const LogTest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    final UserOso? user = provider.userOso;

    return Container(
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
    );
  }
}
