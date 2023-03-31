import 'package:comeloso_app/firebase_options.dart';
import 'package:comeloso_app/screen/home_page.dart';
import 'package:comeloso_app/screen/landing_page.dart';
import 'package:comeloso_app/screen/login_page.dart';
import 'package:comeloso_app/provider/google_sign_in.dart';
import 'package:comeloso_app/provider/user_data.dart';
import 'package:comeloso_app/theme/app_theme.dart';
import 'package:comeloso_app/utils/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => GoogleSignInProvider()),
      ChangeNotifierProvider(create: (context) => UserDataProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SizeConfiguration(
      builder: (_) => MaterialApp(
        title: 'ComelOso',
        theme: AppTheme.light(),
        initialRoute: "/home",
        debugShowCheckedModeBanner: false,
        routes: {
          '/landin': (context) => const LandingPage(),
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage()
        },
      ),
    );
  }
}
