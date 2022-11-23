import 'package:comeloso_app/firebase_options.dart';
import 'package:comeloso_app/pages/home_page.dart';
import 'package:comeloso_app/pages/landing_page.dart';
import 'package:comeloso_app/pages/login_page.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'ComelOso',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage()
        },
      ),
    );
  }
}
